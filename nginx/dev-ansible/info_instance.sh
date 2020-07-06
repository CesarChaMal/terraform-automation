#!/bin/bash

# module.instances-provisioner.aws_instance.instance:
#resource "aws_instance" "instance" {
#    ami                          = "ami-074a2642e2a3737d2"
#    arn                          = "arn:aws:ec2:eu-central-1:774145483743:instance/i-0bd17e95ee797d81b"
#    associate_public_ip_address  = true
#    availability_zone            = "eu-central-1a"
#    cpu_core_count               = 1
#    cpu_threads_per_core         = 1
#    disable_api_termination      = false
#    ebs_optimized                = false
#    get_password_data            = false
#    hibernation                  = false
#    id                           = "i-0bd17e95ee797d81b"
#    instance_state               = "running"
#    instance_type                = "t2.micro"
#    ipv6_address_count           = 0
#    ipv6_addresses               = []
#    key_name                     = "mykeypair-apache-dev"
#    monitoring                   = false
#    primary_network_interface_id = "eni-02413b43683ed70e9"
#    private_dns                  = "ip-10-0-101-107.eu-central-1.compute.internal"
#    private_ip                   = "10.0.101.107"
#    public_ip                    = "18.196.179.77"
#    security_groups              = []
#    source_dest_check            = true
#    subnet_id                    = "subnet-0715ff704bf99597b"
#    tags                         = {
#        "Application"  = "apache"
#        "Environmnent" = "dev"
#        "Name"         = "apache-dev-instance"
#    }


terraform show | grep aws_instance -B 0 -A 35 | grep Name | awk {'print $3'} | sed 's/"//g' | xargs echo "Instance name: " > info_instance.txt
terraform show | grep aws_instance -B 0 -A 35 | grep public_ip | grep -v associate_public_ip_address | awk {'print $3'} | sed 's/"//g' | xargs echo "Public ip: " >> info_instance.txt
terraform show | grep aws_instance -B 0 -A 35 | grep private_dns | awk {'print $3'} | sed 's/"//g' | xargs echo "Private dns: " >> info_instance.txt
terraform show | grep aws_instance -B 0 -A 35 | grep availability_zone | awk {'print $3'} | sed 's/"//g' | xargs echo "Zone: " >> info_instance.txt

