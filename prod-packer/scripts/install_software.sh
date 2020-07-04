#!/bin/bash
apt-get update
apt-get install -y nginx
echo "127.0.0.1 $(hostname)" >> /etc/hosts
