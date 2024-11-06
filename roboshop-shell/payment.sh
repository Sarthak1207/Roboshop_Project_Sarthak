#install python 3
dnf install python3 gcc python3-devel -y

#add application user
useradd roboshop

#setup app directory
mkdir /app

#download the application code
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip
cd /app
unzip /tmp/payment.zip

#download the dependencies
cd /app
pip3 install -r requirements.txt

#Setup payment service
vim /etc/systemd/system/payment.service

#load the service
systemctl daemon-reload

#start the service
systemctl enable payment
systemctl start payment