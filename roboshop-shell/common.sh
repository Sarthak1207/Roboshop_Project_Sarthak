color="\e[35m"
no_color="\e[0m"
log_file=/tmp/roboshop.log
rm -rf $log_file

app_prerequsites {
    print_heading "add application user"
    id roboshop $>>$log_file
    if [ $? -eq = 0]; then
        useradd roboshop $>>$log_file
    fi
    status_check $?
    print_heading "setup app directory"
    mkdir /app $>>$log_file
    status_check $?

    print_heading "download the application code"
    curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip $>>$log_file
    cd /app $>>$log_file
    unzip /tmp/$app_name.zip $>>$log_file
    status_check $?
}

print_heading () {
    echo -e "$color $1 $no_color" $>>$log_file
    echo -e "$color $1 $no_color"
}

status_check () {
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Success $no_color"
    else
        echo -e "\e[33m Failure $no_color"
        exit 1
}