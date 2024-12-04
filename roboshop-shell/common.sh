color="\e[35m"
no_color="\e[0m"
log_file=/tmp/roboshop.log
script_path=$(pwd)
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
    fi
}

systemd_setup {
    print_heading " setup the $app_name service file "
    print_heading " file is placed in roboshop project "
    cp $script_path/$app_name.service /etc/systemd/system/ $>>$log_file
    status_check $?

    print_heading " load the service "
    systemctl daemon-reload $>>$log_file
    status_check $?

    print_heading " Start the service "
    systemctl enable $app_name $>>$log_file
    systemctl restart $app_name $>>$log_file
    status_check $?
}

nodejs_setup {
    print_heading " install nodejs "
    dnf module disable nodejs -y $>>$log_file
    dnf module enable nodejs:20 -y $>>$log_file
    dnf install nodejs -y $>>$log_file
    status_check $?

    app_prerequsites

    print_heading " Download the dependencies "
    cd /app $>>$log_file
    npm install $>>$log_file
    status_check $?

    systemd_setup
}