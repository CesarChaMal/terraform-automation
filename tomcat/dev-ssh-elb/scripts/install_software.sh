#!/bin/bash

# sleep until instance is ready
#until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
#  sleep 1
#done

#whoami
# install tomcat
echo "127.0.0.1 $(hostname)" >> /etc/hosts
apt-get update
apt-get install -y default-jdk
mkdir -p /opt/tomcat
groupadd tomcat
useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
wget http://apache.mirror.digitalpacific.com.au/tomcat/tomcat-8/v8.5.61/bin/apache-tomcat-8.5.61.tar.gz
tar -xzvf apache-tomcat-8.5.61.tar.gz
rm -f apache-tomcat-8.5.61.tar.gz
mv apache-tomcat-8.5.61/* /opt/tomcat
ln -s /opt/tomcat /opt/tomcat/latest
chown -R tomcat /opt/tomcat
chgrp -R tomcat /opt/tomcat
chmod -R 755 /opt/tomcat
sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'
echo "export CATALINA_HOME="/opt/tomcat"" >> ~/.bashrc
source ~/.bashrc
cat /tmp/conf/tomcat.service > /etc/systemd/system/tomcat.service
cat /etc/systemd/system/tomcat.service

ufw allow 8080/tcp
systemctl daemon-reload
systemctl enable tomcat
systemctl start tomcat
#systemctl status tomcat

