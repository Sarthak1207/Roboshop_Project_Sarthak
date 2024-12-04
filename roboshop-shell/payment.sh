#source is used to refer on any script which we want to use in existing script
source common.sh

#declaring varibale used in function
$app_name=payment
status_check $?

print_heading "install python 3"
dnf install python3 gcc python3-devel -y $>>$log_file
status_check $?

app_prerequsites
status_check $?

print_heading "download the dependencies"
pip3 install -r requirements.txt $>>$log_file
status_check $?

print_heading "Setup payment service"
cp /home/ec2-user/Roboshop_Project/roboshop-shell/payment.service /etc/systemd/system/ $>>$log_file
status_check $?

print_heading "load the service"
systemctl daemon-reload $>>$log_file
status_check $?

print_heading "start the service"
systemctl enable payment $>>$log_file
systemctl restart payment $>>$log_file
status_check $?