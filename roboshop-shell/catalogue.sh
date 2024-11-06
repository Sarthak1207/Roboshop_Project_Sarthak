#File for setup systemd catalogue service
#File is available in roboshop_project in git repository
cp /home/ec2-user/Roboshop_Project/roboshop-shell/catalogue.service /etc/systemd/system/

#file is placed in roboshop project
cp  /home/ec2-user/Roboshop_Project/roboshop-shell/mongo.repo /etc/yum.repos.d/

#Install Nodejs
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

#Add application user
useradd roboshop

#Create aap directory
mkdir /app

#Download the application code to create app directory
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip
 
#Download dependencies
cd /amp
npm install

#Install mongodb
dnf install mongodb-mongosh -y

#Load Master Data of the List of products we want to sell and their quantity information also there in the same master data.
mongosh --host 172.31.39.192 </app/db/master-data.js

#load the service
systemctl daemon-reload

#Start the service
systemctl enable catalogue
systemctl restart catalogue

#You need to update catalogue server ip address in frontend configuration. Configuration file is /etc/nginx/nginx.conf