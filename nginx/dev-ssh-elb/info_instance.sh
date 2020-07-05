#!/bin/bash

# module.instances-provisioner.aws_elb.elb:
#resource "aws_elb" "elb" {
#    arn                         = "arn:aws:elasticloadbalancing:eu-central-1:774145483743:loadbalancer/elb-apache-dev"
#    availability_zones          = [
#        "eu-central-1a",
#        "eu-central-1b",
#        "eu-central-1c",
#    ]
#    connection_draining         = true
#    connection_draining_timeout = 400
#    cross_zone_load_balancing   = true
#    dns_name                    = "elb-apache-dev-1840122139.eu-central-1.elb.amazonaws.com"
#    id                          = "elb-apache-dev"
#    idle_timeout                = 60
#    instances                   = []
#    internal                    = false
#    name                        = "elb-apache-dev"
#    security_groups             = [
#        "sg-0470d54f5b4b3724b",
#        "sg-063e3bd4da55d095e",
#        "sg-0a1eab2b3e129d493",
#    ]
#    source_security_group       = "774145483743/allow-ssh-dev"
#    source_security_group_id    = "sg-063e3bd4da55d095e"
#    subnets                     = [
#        "subnet-0108d1ff72082b37b",
#        "subnet-079fd427e810f441b",
#        "subnet-0d9ba3c316ee2aa60",
#    ]
#    tags                        = {
#        "Application"  = "apache"
#        "Environmnent" = "dev"
#        "Name"         = "elb-apache-dev"
#    }


terraform show | grep aws_elb -B 0 -A 60 | grep Name | awk {'print $3'} | sed 's/"//g' | xargs echo "Load balancer name: " > info_instance.txt
terraform show | grep aws_elb -B 0 -A 60 | grep dns_name | awk {'print $3'} | sed 's/"//g' | xargs echo "Dns name: " >> info_instance.txt

