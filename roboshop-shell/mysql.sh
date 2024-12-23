#source is used to refer on any script which we want to use in existing script
source common.sh
my_sql_root_password=$1

if [ -z "$1" ]; then
    echo Input my sql root password is missing
    exit 1
fi

print_heading " install mysql server "
dnf install mysql-server -y  $>>$log_file
status_check $?

print_heading " start mysql service "
systemctl enable mysqld  $>>$log_file
systemctl restart mysqld  $>>$log_file
status_check $?

print_heading " update default root password for mysql-server "
mysql_secure_installation --set-root-pass $my_sql_root_password  $>>$log_file
status_check $?