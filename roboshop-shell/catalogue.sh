#source is used to refer on any script which we want to use in existing script
source common.sh

print_heading " File for setup systemd catalogue service "
print_heading " File is available in roboshop_project in git repository "
cp /home/ec2-user/Roboshop_Project/roboshop-shell/catalogue.service /etc/systemd/system/ $>>$log_file
status_check $?

print_heading " file is placed in roboshop project "
cp  /home/ec2-user/Roboshop_Project/roboshop-shell/mongo.repo /etc/yum.repos.d/ $>>$log_file
status_check $?

print_heading " Install Nodejs "
dnf module disable nodejs -y $>>$log_file
dnf module enable nodejs:20 -y $>>$log_file
dnf install nodejs -y $>>$log_file
status_check $?

print_heading " Add application user "
useradd roboshop $>>$log_file
status_check $?

print_heading " Create aap directory "
mkdir /app $>>$log_file
status_check $?

print_heading " Download the application code to create app directory "
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip $>>$log_file
cd /app $>>$log_file
unzip /tmp/catalogue.zip $>>$log_file
status_check $?
 
print_heading " Download dependencies "
cd /app $>>$log_file
npm install $>>$log_file
status_check $?

print_heading " Install mongodb "
dnf install mongodb-mongosh -y $>>$log_file
status_check $?

print_heading " Load Master Data of the List of products we want to sell and their quantity information also there in the same master data. "
mongosh --host mongodb.sarthak1207.shop </app/db/master-data.js $>>$log_file
status_check $?

print_heading " load the service "
systemctl daemon-reload $>>$log_file
status_check $?

print_heading " Start the service "
systemctl enable catalogue $>>$log_file
systemctl restart catalogue $>>$log_file
status_check $?

print_heading " You need to update catalogue server ip address in frontend configuration. Configuration file is /etc/nginx/nginx.conf "