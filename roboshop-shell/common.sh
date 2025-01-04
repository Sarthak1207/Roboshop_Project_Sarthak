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
    curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip $>>$log_file
    cd /app $>>$log_file
    unzip /tmp/$component.zip $>>$log_file
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
    print_heading " setup the $component service file "
    print_heading " file is placed in roboshop project "
    cp $script_path/$component.service /etc/systemd/system/ $>>$log_file
    sed -i -e "s/rabiit_mq_pass/${rabiit_mq_pass}/" /etc/systemd/system/$component.service $>>$log_file
    status_check $?

    print_heading " load the service "
    systemctl daemon-reload $>>$log_file
    status_check $?

    print_heading " Start the service "
    systemctl enable $component $>>$log_file
    systemctl restart $component $>>$log_file
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
    mv target/$component-1.0.jar $component.jar  $>>$log_file
    status_check $?

    systemd_setup
}

golang_setup {
    print_heading "install golang"
    dnf install golang -y $>>$log_file
    status_check $?

    app_prerequsites
    status_check $?

    print_heading "Download the dependencies"
    cd /app $>>$log_file
    go mod init dispatch $>>$log_file
    go get $>>$log_file
    go build $>>$log_file
    status_check $?

    systemd_setup
}