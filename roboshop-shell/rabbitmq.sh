#Setup rabbitmq repo file
cp /home/ec2-user/Roboshop_Project/roboshop-shell/rabbitmq.repo /etc/yum.repos.d/

#Install rabbitmq
dnf install rabbitmq-server -y

#start rabbitmq service
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server

#updating username and password for rabbitmq to connect
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"