#source is used to refer on any script which we want to use in existing script
source common.sh

print_heading " setup the mongodb repo file "
print_heading " file is placed in roboshop project "
cp $script_path/mongo.repo /etc/yum.repos.d/  $>>$log_file
status_check $?

print_heading " install mongodb "
dnf install mongodb-org -y  $>>$log_file
status_check $?

print_heading " update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf "
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf  $>>$log_file
status_check $?

print_heading " start and enable mongodb service "
systemctl enable mongod  $>>$log_file
systemctl restart mongod  $>>$log_file
status_check $?
