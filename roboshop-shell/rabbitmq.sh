#source is used to refer on any script which we want to use in existing script
source common.sh

echo -e "$color Setup rabbitmq repo file $no_color"
cp /home/ec2-user/Roboshop_Project/roboshop-shell/rabbitmq.repo /etc/yum.repos.d/

echo -e "$color Install rabbitmq $no_color"
dnf install rabbitmq-server -y

echo -e "$color start rabbitmq service $no_color"
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server

echo -e "$color updating username and password for rabbitmq to connect $no_color"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"