#setup the mongodb repo file
#file is placed in roboshop project
cp /home/ec2-user/Roboshop_Project/roboshop-shell/mongo.repo /etc/yum.repos.d/

#install mongodb
dnf install mongodb-org -y

#update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf

#start and enable mongodb service
systemctl enable mongod
systemctl restart mongod

