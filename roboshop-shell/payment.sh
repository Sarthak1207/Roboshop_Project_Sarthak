echo -e "$color install python 3 $no_color"
dnf install python3 gcc python3-devel -y

echo -e "$color add application user $no_color"
useradd roboshop

echo -e "$color setup app directory $no_color"
mkdir /app

echo -e "$color download the application code $no_color"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip
cd /app
unzip /tmp/payment.zip

echo -e "$color download the dependencies $no_color"
pip3 install -r requirements.txt

echo -e "$color Setup payment service $no_color"
cp /home/ec2-user/Roboshop_Project/roboshop-shell/payment.service /etc/systemd/system/

echo -e "$color load the service $no_color"
systemctl daemon-reload

echo -e "$color start the service $no_color"
systemctl enable payment
systemctl restart payment