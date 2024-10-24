#setup the mongodb repo file
#file is placed in roboshop project
vim /etc/yum.repo.d/mongo.repo

#install mongodb
dnf install mongodb-org -y

#start and enable mongodb service
systemctl enable mongod
systemctl start mongod

#update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf

#rRestart the service to make the changes effected
systemctl restart mongod