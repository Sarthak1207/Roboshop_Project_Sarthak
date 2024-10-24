#Setup rabbitmq repo file
vim /etc/yum.repos.d/rabbitmq.repo

#Install rabbitmq
dnf install rabbitmq-server -y

#start rabbitmq service
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

#updating username and password for rabbitmq to connect
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"