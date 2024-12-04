#source is used to refer on any script which we want to use in existing script
source common.sh

print_heading " install nodejs "
dnf module disable nodejs -y $>>$log_file
dnf module enable nodejs:20 -y $>>$log_file
dnf install nodejs -y $>>$log_file
status_check $?

print_heading " add application user "
useradd roboshop $>>$log_file
status_check $?

print_heading " setup aaplication directory "
rm -rf /app
mkdir /app
status_check $?

print_heading " download the application code to created app directory "
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip $>>$log_file
cd /app $>>$log_file
unzip /tmp/cart.zip $>>$log_file
status_check $?

print_heading " Download the dependencies "
cd /app $>>$log_file
npm install $>>$log_file
status_check $?

print_heading " setup the cart service file "
print_heading " file is placed in roboshop project "
cp /home/ec2-user/Roboshop_Project/roboshop-shell/cart.service /etc/systemd/system/ $>>$log_file
status_check $?

print_heading " load the service "
systemctl daemon-reload $>>$log_file
status_check $?

print_heading " Start the service "
systemctl enable cart $>>$log_file
systemctl restart cart $>>$log_file
status_check $?