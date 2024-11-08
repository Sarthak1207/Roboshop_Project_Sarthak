#Install nginx
dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y

#Remove teh default contant that web server is serving
rm -rf /usr/share/nginx/html/*

#Download the frontend content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

#Extract the frontend content
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

#Create nginx reverese proxy configuration to each backend service
#nginx file is place in git under roboshop project
cp /home/ec2-user/Roboshop_Project/roboshop-shell/nginx.conf /etc/nginx/

#Start and Enable nginx service
systemctl enable nginx
systemctl restart nginx