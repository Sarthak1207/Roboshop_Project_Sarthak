#source is used to refer on any script which we want to use in existing script
source common.sh

echo -e "$color install maven $no_color"
dnf install maven -y

echo -e "$color add application user $no_color"
useradd roboshop

echo -e "$color setup application directory $no_color"
mkdir /app

echo -e "$color download the application code $no_color"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip /tmp/shipping.zip

echo -e "$color download dependencies $no_color"
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "$color Setup systemd shipping service $no_color"
cp /home/ec2-user/Roboshop_Project/roboshop-shell/shipping.service /etc/systemd/system/

echo -e "$color Load the service $no_color"
systemctl daemon-reload

echo -e "$color Install mysql $no_color"
dnf install mysql -y

echo -e "$color Load schema in database $no_color"
mysql -h mysql.sarthak1207.shop -uroot -pRoboShop@1 < /app/db/schema.sql
echo -e "$color Create the user in mysql $no_color"
mysql -h mysql.sarthak1207.shop -uroot -pRoboShop@1 < /app/db/app-user.sql
echo -e "$color Load the master data $no_color"
mysql -h mysql.sarthak1207.shop -uroot -pRoboShop@1 < /app/db/master-data.sql

echo -e "$color start the service $no_color"
systemctl enable shipping
systemctl restart shipping