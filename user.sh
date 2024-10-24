#Install Nodejs
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

#Add application user
useradd roboshop

#Create /app directory
mkdir /app

#Download the application code to created app directory
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip
cd /app
unzip /tmp/user.zip

#Download dependencies
cd /app
npm install

#setup systemd user service
#file is placed in roboshop project
vim /etc/systemd/system/user.service

#Load the service
systemctl daemon-reload

#Start the service
systemctl enable user
systemctl start user