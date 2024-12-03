echo -e "$color Install nginx $no_color"
dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y

echo -e "$color Remove teh default contant that web server is serving $no_color"
rm -rf /usr/share/nginx/html/*

echo -e "$color Download the frontend content $no_color"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

echo -e "$color Extract the frontend content $no_color"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "$color Create nginx reverese proxy configuration to each backend service $no_color"
echo -e "$color nginx file is place in git under roboshop project $no_color"
cp /home/ec2-user/Roboshop_Project/roboshop-shell/nginx.conf /etc/nginx/

echo -e "$color Start and Enable nginx service $no_color"
systemctl enable nginx
systemctl restart nginx