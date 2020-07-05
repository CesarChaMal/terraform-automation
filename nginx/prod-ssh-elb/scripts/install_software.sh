#!/bin/bash

# sleep until instance is ready
#until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
#  sleep 1
#done

#whoami
# install nginx
echo "127.0.0.1 $(hostname)" >> /etc/hosts
apt-get update
apt-get -y install nginx

# make sure nginx is started
systemctl start nginx
