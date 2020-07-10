#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

#whoami
# install nginx
echo "127.0.0.1 $(hostname)" >> /etc/hosts
apt-get update
apt-get install -y nginx
#add-apt-repository ppa:nginx/stable

mkdir -p /var/www/localhost
chmod -c 0755 /var/www/localhost
cp /var/www/html/index.nginx-debian.html /var/www/localhost/index.html
#cp /tmp/conf/index.html /var/www/localhost/index.html

cp /tmp/conf/nginx.conf /etc/nginx/nginx.conf
#cat /etc/nginx/nginx.conf

cp /tmp/conf/virtual_host.conf /etc/nginx/sites-available/localhost
#cat /etc/nginx/sites-available/localhost

grep -rinl 'listen 80 default_server;' /etc/nginx/sites-available/default | xargs sed -i 's/listen 80 default_server;/listen 80;/g'
grep -rinl 'listen \[::\]:80 default_server;' /etc/nginx/sites-available/default | xargs sed -i 's/listen \[::\]:80 default_server;/listen \[::\]:80;/g'
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

systemctl reload nginx
systemctl daemon-reload
systemctl enable nginx
systemctl start nginx
