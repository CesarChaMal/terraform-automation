#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

#whoami
# install apache
echo "127.0.0.1 $(hostname)" >> /etc/hosts
apt-get update
apt-get install -y apache2
mkdir -p /var/www/localhost
#cp /var/www/html/index.html /var/www/localhost/index.html
cp /tmp/conf/index.html /var/www/localhost/index.html
cat /tmp/conf/apache.conf > /etc/apache2/sites-available/apache.conf
cat /etc/apache2/sites-available/apache.conf
sudo a2ensite localhost
service apache2 reload

systemctl daemon-reload
systemctl enable apache2
systemctl start apache2
