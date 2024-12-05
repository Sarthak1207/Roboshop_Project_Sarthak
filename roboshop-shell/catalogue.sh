#source is used to refer on any script which we want to use in existing script
source common.sh
#declaring varibale used in function
app_name=catalogue

nodejs_setup

print_heading " file is placed in roboshop project "
cp  $script_path/mongo.repo /etc/yum.repos.d/ $>>$log_file
status_check $?

print_heading " Install mongodb "
dnf install mongodb-mongosh -y $>>$log_file
status_check $?

print_heading " Load Master Data of the List of products we want to sell and their quantity information also there in the same master data. "
mongosh --host mongodb.sarthak1207.shop </app/db/master-data.js $>>$log_file
status_check $?

print_heading " restart the service "
systemctl restart catalogue $>>$log_file
status_check $?

print_heading " You need to update catalogue server ip address in frontend configuration. Configuration file is /etc/nginx/nginx.conf "