#source is used to refer on any script which we want to use in existing script
source common.sh
rabiit_mq_pass=$1
#rabiit_mq_pass=roboshop123

if [ -z "$1" ]; then
    echo Input my rabbitmq password is missing
    exit 1
fi

print_heading " Setup rabbitmq repo file "
cp $script_path/rabbitmq.repo /etc/yum.repos.d/  $>>$log_file
status_check $?

print_heading " Install rabbitmq "
dnf install rabbitmq-server -y  $>>$log_file
status_check $?

print_heading " start rabbitmq service "
systemctl enable rabbitmq-server  $>>$log_file
systemctl restart rabbitmq-server  $>>$log_file
status_check $?

print_heading " updating username and password for rabbitmq to connect "
rabbitmqctl add_user roboshop $rabiit_mq_pass  $>>$log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  $>>$log_file
status_check $?