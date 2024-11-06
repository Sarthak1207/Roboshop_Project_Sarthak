#Install Ngnix
dnf module disable ngnix -y
dnf module enable ngnix:1.24 -y
dnf install ngnix -y

#Extract the frontend content
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

#Remove teh default contant that web server is serving
rm -rf /usr/share/ngnix/html/*

#Download the frontend content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

#Create Ngnix reverese proxy configuration to each backend service
#nginx file is place in git under roboshop project
cp /home/ec2-user/Roboshop_Project/roboshop-shell/nginx.conf /etc/nginx/

#Start and Enable Ngnix service
systemctl enable nginx
systemctl start nginx