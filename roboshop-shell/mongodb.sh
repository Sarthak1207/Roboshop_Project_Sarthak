echo -e "$color setup the mongodb repo file $no_color"
echo -e "$color file is placed in roboshop project $no_color"
cp /home/ec2-user/Roboshop_Project/roboshop-shell/mongo.repo /etc/yum.repos.d/

echo -e "$color install mongodb $no_color"
dnf install mongodb-org -y

echo -e "$color update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf $no_color"
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf

echo -e "$color start and enable mongodb service $no_color"
systemctl enable mongod
systemctl restart mongod

