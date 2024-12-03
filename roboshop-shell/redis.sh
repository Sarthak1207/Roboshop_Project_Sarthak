echo -e "$color install redis $no_color"
dnf module disable redis -y
dnf module enable redis:7 -y
dnf install redis -y

echo -e "$color Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis/redis.conf $no_color"
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf
sed -i -e '/protected-mode/s/yes/no/g' /etc/redis/redis.conf

echo -e "$color Start and enable redis service $no_color"
systemctl enable redis
systemctl restart redis