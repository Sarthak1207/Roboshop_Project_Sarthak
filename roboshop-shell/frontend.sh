#source is used to refer on any script which we want to use in existing script
source common.sh
#declaring varibale used in function
$app_name=frontend

print_heading " Install nginx "
dnf module disable nginx -y  $>>$log_file
dnf module enable nginx:1.24 -y $>>$log_file
dnf install nginx -y  $>>$log_file
status_check $?

print_heading " Remove teh default contant that web server is serving "
rm -rf /usr/share/nginx/html/*  $>>$log_file
status_check $?

print_heading " Download the $app_name content "
curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip  $>>$log_file
status_check $?

print_heading " Extract the $app_name content "
cd /usr/share/nginx/html  $>>$log_file
unzip /tmp/$app_name.zip  $>>$log_file
status_check $?

print_heading " Create nginx reverese proxy configuration to each backend service "
print_heading " nginx file is place in git under roboshop project "
cp /home/ec2-user/Roboshop_Project/roboshop-shell/nginx.conf /etc/nginx/  $>>$log_file
status_check $?

print_heading " Start and Enable nginx service "
systemctl enable nginx  $>>$log_file
systemctl restart nginx  $>>$log_file
status_check $?