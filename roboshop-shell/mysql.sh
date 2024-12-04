#source is used to refer on any script which we want to use in existing script
source common.sh

echo -e "$color install mysql server $no_color"
dnf install mysql-server -y

echo -e "$color start mysql service $no_color"
systemctl enable mysqld
systemctl restart mysqld

echo -e "$color update default root password for mysql-server $no_color"
mysql_secure_installation --set-root-pass RoboShop@1