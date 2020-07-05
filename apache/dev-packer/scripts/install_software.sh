#!/bin/bash
# install apache
echo "127.0.0.1 $(hostname)" >> /etc/hosts
apt-get update
apt-get install -y apache2

# make sure apache is started
service apache2 start
