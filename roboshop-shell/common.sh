color="\e[35m"
no_color="\e[0m"

app_prerequsites {
    echo -e "$color add application user $no_color"
    useradd roboshop

    echo -e "$color setup app directory $no_color"
    mkdir /app

    echo -e "$color download the application code $no_color"
    curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip
    cd /app
    unzip /tmp/$app_name.zip
}