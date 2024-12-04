#source is used to refer on any script which we want to use in existing script
source common.sh

echo -e "$color Install Nodejs $no_color"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

echo -e "$color Add application user $no_color"
useradd roboshop

echo -e "$color Create /app directory $no_color"
mkdir /app

echo -e "$color Download the application code to created app directory $no_color"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip
cd /app
unzip /tmp/user.zip

echo -e "$color Download dependencies $no_color"
cd /app
npm install

echo -e "$color setup systemd user service $no_color"
echo -e "$color file is placed in roboshop project $no_color"
cp /home/ec2-user/Roboshop_Project/roboshop-shell/user.service /etc/systemd/system/

echo -e "$color Load the service $no_color"
systemctl daemon-reload

echo -e "$color Start the service $no_color"
systemctl enable user
systemctl restart user