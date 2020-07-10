#!/bin/bash
# install apache
echo "127.0.0.1 $(hostname)" >> /etc/hosts
apt-get update
apt-get install -y apache2
mkdir -p /var/www/localhost
chmod -c 0755 /var/www/localhost
cp /var/www/html/index.html /var/www/localhost/index.html
#cp /tmp/conf/index.html /var/www/localhost/index.html

virtualHost = "<VirtualHost *:80>"
virtualHost = "$virtualHost ServerAdmin webmaster@localhost "
virtualHost = "$virtualHost ServerName localhost "
virtualHost = "$virtualHost ServerAlias www.localhost "
virtualHost = "$virtualHost DocumentRoot /var/www/localhost "
virtualHost = "$virtualHost ErrorLog /var/www/localhost/error.log "
virtualHost = "$virtualHost CustomLog /var/www/localhost/access.log combined "
virtualHost = "$virtualHost </VirtualHost>" 
echo $virtualHost >> /etc/apache2/sites-available/localhost.conf

#cp /tmp/conf/apache.conf /etc/apache2/sites-available/localhost.conf
#cat /etc/apache2/sites-available/localhost.conf

/usr/sbin/a2ensite localhost.conf
/usr/sbin/a2dissite 000-default.conf

systemctl reload apache2
systemctl daemon-reload
systemctl enable apache2
systemctl start apache2
