#source is used to refer on any script which we want to use in existing script
source common.sh

print_heading " Install Nodejs "
dnf module disable nodejs -y  $>>$log_file
dnf module enable nodejs:20 -y  $>>$log_file
dnf install nodejs -y  $>>$log_file
status_check $?

print_heading " Add application user "
useradd roboshop  $>>$log_file
status_check $?

print_heading " Create /app directory "
mkdir /app  $>>$log_file
status_check $?

print_heading " Download the application code to created app directory "
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip  $>>$log_file
cd /app  $>>$log_file
unzip /tmp/user.zip  $>>$log_file
status_check $?

print_heading " Download dependencies "
cd /app  $>>$log_file
npm install  $>>$log_file
status_check $?

print_heading " setup systemd user service "
print_heading " file is placed in roboshop project "
cp /home/ec2-user/Roboshop_Project/roboshop-shell/user.service /etc/systemd/system/  $>>$log_file
status_check $?

print_heading " Load the service "
systemctl daemon-reload  $>>$log_file
status_check $?

print_heading " Start the service "
systemctl enable user  $>>$log_file
systemctl restart user  $>>$log_file
status_check $?