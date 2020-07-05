#!/bin/bash
echo "127.0.0.1 $(hostname)" >> /etc/hosts
apt-get update
apt-get install -y nginx
