#source is used to refer on any script which we want to use in existing script
source common.sh
#declaring varibale used in function
app_name=shipping
my_sql_root_password=$1

if [ -z "$1" ]; then
    echo Input my sql root password is missing
    exit 1
fi

maven_setup

print_heading " Install mysql "
dnf install mysql -y  $>>$log_file
status_check $?

print_heading " Load schema in database "
print_heading " Create the user in mysql " 
print_heading " Load the master data "

for sql_file in schema app-user master-data; do 
    mysql -h mysql.sarthak1207.shop -uroot -p$my_sql_root_password < /app/db/schema.sql  $>>$log_file
    status_check $?
done

print_heading "Restart shipping service"
systemctl restart shipping $>>$log_file
status_check $? 
