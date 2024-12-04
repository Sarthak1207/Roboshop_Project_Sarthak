#source is used to refer on any script which we want to use in existing script
source common.sh
#declaring varibale used in function
$app_name=shipping

print_heading " install maven "
dnf install maven -y  $>>$log_file
status_check $?

app_prerequsites

print_heading " download dependencies "
cd /app  $>>$log_file
mvn clean package  $>>$log_file
mv target/shipping-1.0.jar shipping.jar  $>>$log_file
status_check $?

print_heading " Install mysql "
dnf install mysql -y  $>>$log_file
status_check $?

print_heading " Load schema in database "
print_heading " Create the user in mysql " 
print_heading " Load the master data "

for sql_file in schema app-user master-data; do 
    mysql -h mysql.sarthak1207.shop -uroot -pRoboShop@1 < /app/db/schema.sql  $>>$log_file
    status_check $?
done

systemd_setup