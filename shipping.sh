#install maven
dnf install maven -y

#add application user
useradd roboshop

#setup application directory
mkdir /app

#download the application code
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip /tnp/shipping.zip

#download dependencies
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

#Setup systemd shipping service
vim /etc/systemd/system/shipping.service

#Load the service
systemctl daemon-reload

#start the service
systemctl enable shipping
systemctl start shipping

#Install mysql
dnf install mysql -y

#Load schema in database
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/schema.sql
#Create the user in mysql
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/app-user.sql
#Load the master data
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/master-data.sql

#Service restart
systemctl restart shipping