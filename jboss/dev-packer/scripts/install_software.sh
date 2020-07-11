#!/bin/bash
echo "127.0.0.1 $(hostname)" >> /etc/hosts
apt-get update
apt-get install -y default-jdk
mkdir -p /opt/wildfly
mkdir -p /etc/wildfly/ 
groupadd wildfly
useradd -r -g wildfly -d /opt/wildfly -s /sbin/nologin wildfly
wget https://download.jboss.org/wildfly/16.0.0.Final/wildfly-16.0.0.Final.tar.gz
tar -xzvf wildfly-16.0.0.Final.tar.gz
rm -f wildfly-16.0.0.Final.tar.gz
mv wildfly-16.0.0.Final/* /opt/wildfly
#ln -s /opt/wildfly /opt/wildfly/latest
chown -R wildfly /opt/wildfly
chgrp -R wildfly /opt/wildfly
chmod -R 755 /opt/wildfly
#chmod o+x /opt/wildfly/bin/

#cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/wildfly.conf
#cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/launch.sh
#cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/wildfly.service

cp /tmp/conf/wildfly.conf /etc/wildfly/wildfly.conf
cp /tmp/conf/launch.sh /opt/wildfly/bin/launch.sh
cp /tmp/conf/wildfly.service /etc/systemd/system/wildfly.service

chown wildfly: /opt/wildfly/bin/launch.sh
#sh -c 'chmod +x /opt/wildfly/latest/bin/*.sh'
sh -c 'chmod +x /opt/wildfly/bin/*.sh'
chmod +x /opt/wildfly/bin/launch.sh

ufw allow 8080/tcp
systemctl daemon-reload
systemctl enable wildfly
systemctl start wildfly

