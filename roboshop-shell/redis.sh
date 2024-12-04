#source is used to refer on any script which we want to use in existing script
source common.sh

print_heading " install redis "
dnf module disable redis -y  $>>$log_file
dnf module enable redis:7 -y  $>>$log_file
dnf install redis -y  $>>$log_file
status_check $?

print_heading " Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis/redis.conf "
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf  $>>$log_file
sed -i -e '/protected-mode/s/yes/no/g' /etc/redis/redis.conf  $>>$log_file
status_check $?

print_heading " Start and enable redis service "
systemctl enable redis  $>>$log_file
systemctl restart redis  $>>$log_file
status_check $?