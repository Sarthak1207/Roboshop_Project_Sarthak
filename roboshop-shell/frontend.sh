#Install Ngnix
dnf module disable ngnix -y
dnf module enable ngnix:1.24 -y
dnf install ngnix -y

#Start and Enable Ngnix service
systemctl enable nginx
systemctl start nginx

#Remove teh default contant that web server is serving
rm -rf /usr/share/ngnix/html/*

#Download the frontend content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

#Extract the frontend content
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

#Create Ngnix reverese proxy configuration to each backend service
#nginx file is place in git under roboshop project
vim /etc/nginx/nginx.conf

#Restart Nginx Service to load the changes of the configuration
systemctl restart nginx