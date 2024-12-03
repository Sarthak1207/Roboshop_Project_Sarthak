echo -e "$color File for setup systemd catalogue service $no_color"
echo -e "$color File is available in roboshop_project in git repository $no_color"
cp /home/ec2-user/Roboshop_Project/roboshop-shell/catalogue.service /etc/systemd/system/

echo -e "$color file is placed in roboshop project $no_color"
cp  /home/ec2-user/Roboshop_Project/roboshop-shell/mongo.repo /etc/yum.repos.d/

echo -e "$color Install Nodejs $no_color"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

echo -e "$color Add application user $no_color"
useradd roboshop

echo -e "$color Create aap directory $no_color"
mkdir /app

echo -e "$color Download the application code to create app directory $no_color"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip
 
echo -e "$color Download dependencies $no_color"
cd /app
npm install

echo -e "$color Install mongodb $no_color"
dnf install mongodb-mongosh -y

echo -e "$color Load Master Data of the List of products we want to sell and their quantity information also there in the same master data. $no_color"
mongosh --host mongodb.sarthak1207.shop </app/db/master-data.js

echo -e "$color load the service $no_color"
systemctl daemon-reload

echo -e "$color Start the service $no_color"
systemctl enable catalogue
systemctl restart catalogue

echo -e "$color You need to update catalogue server ip address in frontend configuration. Configuration file is /etc/nginx/nginx.conf $no_color"