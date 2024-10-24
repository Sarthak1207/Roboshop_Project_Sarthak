#install golang
dnf install golang -y

#add application user
useradd roboshop

#setup application directory
mkdir /app

#download the application code
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app
unzip /tmp/dispatch.zip

#Download the dependencies
cd /app
go mod init dispatch
go get
go build

#setup systemd payment service
vim /etc/systemd/system/dipatch.service

#load the service
systemctl daemon-reload

#start the service
systemctl enable dispatch
systemctl start dispatch