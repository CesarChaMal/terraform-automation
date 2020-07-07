#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

#whoami
# install tomcat
echo "127.0.0.1 $(hostname)" >> /etc/hosts
apt-get update
sudo apt-get install -y default-jdk
groupadd tomcat
useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
wget http://apache.mirror.digitalpacific.com.au/tomcat/tomcat-8/v8.5.56/bin/apache-tomcat-8.5.56.tar.gz
tar -xzvf apache-tomcat-8.5.56.tar.gz
mv apache-tomcat-8.5.56 /opt/tomcat
chgrp -R tomcat /opt/tomcat
chown -R tomcat /opt/tomcat
chmod -R 755 /opt/tomcat
cp ../config/tomcat.service /etc/systemd/system/tomcat.service
systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat
