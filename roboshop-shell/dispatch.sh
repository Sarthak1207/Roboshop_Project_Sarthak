echo -e "$color install golang $no_color"
dnf install golang -y

echo -e "$color add application user $no_color"
useradd roboshop

echo -e "$color setup application directory $no_color"
rm -rf /app
mkdir /app

echo -e "$color download the application code $no_color"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app
unzip /tmp/dispatch.zip

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