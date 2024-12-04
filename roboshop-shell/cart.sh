#source is used to refer on any script which we want to use in existing script
source common.sh

echo -e "$color install nodejs $no_color"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

echo -e "$color add application user $no_color"
useradd roboshop

echo -e "$color setup aaplication directory $no_color"
rm -rf /app
mkdir /app

echo -e "$color download the application code to created app directory $no_color"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
unzip /tmp/cart.zip

echo -e "$color Download the dependencies $no_color"
cd /app
npm install

echo -e "$color setup the cart service file $no_color"
echo -e "$color file is placed in roboshop project $no_color"
cp /home/ec2-user/Roboshop_Project/roboshop-shell/cart.service /etc/systemd/system/

echo -e "$color load the service $no_color"
systemctl daemon-reload

echo -e "$color Start the service $no_color"
systemctl enable cart
systemctl restart cart