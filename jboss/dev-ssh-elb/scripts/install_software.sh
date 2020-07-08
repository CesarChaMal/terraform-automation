#!/bin/bash

# sleep until instance is ready
#until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
#  sleep 1
#done

#whoami
# install jboss
echo "127.0.0.1 $(hostname)" >> /etc/hosts
apt-get update
apt-get install -y default-jdk
mkdir -p /opt/wildfly
groupadd wildfly
useradd -r -g wildfly -d /opt/wildfly -s /sbin/nologin wildfly
wget https://download.jboss.org/wildfly/16.0.0.Final/wildfly-16.0.0.Final.tar.gz
tar -xzvf wildfly-16.0.0.Final.tar.gz
mv wildfly-16.0.0.Final/* /opt/wildfly
ln -s /opt/wildfly /opt/wildfly/latest
chown -R wildfly /opt/wildfly
chgrp -R wildfly /opt/wildfly
chmod -R 755 /opt/wildfly
sh -c 'chmod +x /opt/wildfly/latest/bin/*.sh'
#chmod o+x /opt/wildfly/bin/

cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/
cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/
cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/

echo "export CATALINA_HOME="/opt/tomcat"" >> ~/.bashrc
source ~/.bashrc

#cat /tmp/conf/wildfly.conf > /etc/wildfly/wildfly.conf
#cat /etc/wildfly/wildfly.conf

#cat /tmp/conf/launch.sh > /opt/wildfly/bin/launch.sh
#cat /opt/wildfly/bin/launch.sh

#cat /tmp/conf/wildfly.service > /etc/systemd/system/wildfly.service
#cat /opt/wildfly/bin/launch.sh

chown wildfly: /opt/wildfly/bin/launch.sh

systemctl daemon-reload
systemctl enable wildfly
systemctl start wildfly
ufw allow 8080/tcp

