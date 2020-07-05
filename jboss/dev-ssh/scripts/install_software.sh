#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

#whoami
# install jboss
echo "127.0.0.1 $(hostname)" >> /etc/hosts
apt-get update
apt-get install -y jboss

# make sure jboss is started
service jboss start
