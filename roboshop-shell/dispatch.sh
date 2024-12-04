#source is used to refer on any script which we want to use in existing script
source common.sh

#declaring varibale used in function
$app_name=dispatch

echo -e "$color install golang $no_color"
dnf install golang -y

app_prerequsites

echo -e "$color Download the dependencies $no_color"
cd /app
go mod init dispatch
go get
go build

echo -e "$color setup systemd payment service $no_color"
cp /home/ec2-user/Roboshop_Project/roboshop-shell/dispatch.service /etc/systemd/system/

echo -e "$color load the service $no_color"
systemctl daemon-reload

echo -e "$color start the service $no_color"
systemctl enable dispatch
systemctl restart dispatch