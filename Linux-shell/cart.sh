#install nodejs
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

#add application user
useradd roboshop

#setup aaplication directory
mkdir /app

#download the application code to created app directory
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
unzip /tmp/cart.zip

#Download the dependencies
cd /app
npm install

#setup the cart service file
#file is placed in roboshop project
vim /etc/systemd/system/cart.service

#load the service
systemctl daemon-reload

#Start the service
systemctl enable cart
systemctl start cart