#Install Nodejs
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

#Add application user
useradd roboshop

#Create aap directory
mkdir /app

#Download the application code to create app directory
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip
 
#Download dependencies
cd /amp
npm install

#File for setup systemd catalogue service
#File is available in roboshop_project in git repository
vim /etc/systemd/system/catalogue.service

#load the service
systemctl daemon-reload

#Start the service
systemctl enable catalogue
systemctl start catalogue

#file is placed in roboshop project
vim /etc/yum.repo.d/mongo.repo

#Install mongodb
dnf install mongodb-mongosh -y

#Load Master Data of the List of products we want to sell and their quantity information also there in the same master data.
mongosh --host MONGODB-SERVER-IPADDRESS </app/db/master-data.js

#You need to update catalogue server ip address in frontend configuration. Configuration file is /etc/nginx/nginx.conf