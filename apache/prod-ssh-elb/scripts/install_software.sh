#!/bin/bash

# sleep until instance is ready
#until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
#  sleep 1
#done

#whoami
# install apache
echo "127.0.0.1 $(hostname)" >> /etc/hosts
apt-get update
apt-get -y install apache

# make sure apache is started
systemctl start apache2

