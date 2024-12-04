#source is used to refer on any script which we want to use in existing script
source common.sh

#declaring varibale used in function
$app_name=payment

echo -e "$color install python 3 $no_color"
dnf install python3 gcc python3-devel -y

app_prerequsites

echo -e "$color download the dependencies $no_color"
pip3 install -r requirements.txt

echo -e "$color Setup payment service $no_color"
cp /home/ec2-user/Roboshop_Project/roboshop-shell/payment.service /etc/systemd/system/

echo -e "$color load the service $no_color"
systemctl daemon-reload

echo -e "$color start the service $no_color"
systemctl enable payment
systemctl restart payment