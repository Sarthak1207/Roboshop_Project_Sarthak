#source is used to refer on any script which we want to use in existing script
source common.sh

print_heading " install maven "
dnf install maven -y  $>>$log_file
status_check $?

print_heading " add application user "
useradd roboshop $>>$log_file
status_check $?

print_heading " setup application directory "
mkdir /app $>>$log_file
status_check $?

print_heading " download the application code "
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip  $>>$log_file
cd /app  $>>$log_file
unzip /tmp/shipping.zip  $>>$log_file
status_check $?

print_heading " download dependencies "
cd /app  $>>$log_file
mvn clean package  $>>$log_file
mv target/shipping-1.0.jar shipping.jar  $>>$log_file
status_check $?

print_heading " Setup systemd shipping service "
cp /home/ec2-user/Roboshop_Project/roboshop-shell/shipping.service /etc/systemd/system/  $>>$log_file
status_check $?

print_heading " Load the service "
systemctl daemon-reload  $>>$log_file
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

print_heading " start the service "
systemctl enable shipping  $>>$log_file
systemctl restart shipping  $>>$log_file
status_check $?