#source is used to refer on any script which we want to use in existing script
source common.sh

print_heading " Setup rabbitmq repo file "
cp /home/ec2-user/Roboshop_Project/roboshop-shell/rabbitmq.repo /etc/yum.repos.d/  $>>$log_file
status_check $?

print_heading " Install rabbitmq "
dnf install rabbitmq-server -y  $>>$log_file
status_check $?

print_heading " start rabbitmq service "
systemctl enable rabbitmq-server  $>>$log_file
systemctl restart rabbitmq-server  $>>$log_file
status_check $?

print_heading " updating username and password for rabbitmq to connect "
rabbitmqctl add_user roboshop roboshop123  $>>$log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  $>>$log_file
status_check $?