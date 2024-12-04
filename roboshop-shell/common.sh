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

python_setup {
    print_heading "install python 3"
    dnf install python3 gcc python3-devel -y $>>$log_file
    status_check $?

    app_prerequsites
    status_check $?

    print_heading "download the dependencies"
    pip3 install -r requirements.txt $>>$log_file
    status_check $?

    systemd_setup
}

maven_setup {
    print_heading " install maven "
    dnf install maven -y  $>>$log_file
    status_check $?

    app_prerequsites

    print_heading " download dependencies "
    cd /app  $>>$log_file
    mvn clean package  $>>$log_file
    mv target/$app_name-1.0.jar $app_name.jar  $>>$log_file
    status_check $?

    print_heading " Install mysql "
    dnf install mysql -y  $>>$log_file
    status_check $?

    print_heading " Load schema in database "
    print_heading " Create the user in mysql " 
    print_heading " Load the master data "

    for sql_file in schema app-user master-data; do 
        mysql -h mysql.sarthak1207.shop -uroot -pRoboShop@1 < /app/db/schema.sql  $>>$log_file
        status_check $?
    done

    systemd_setup
}