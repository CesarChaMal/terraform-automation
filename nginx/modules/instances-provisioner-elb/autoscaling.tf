resource "aws_launch_configuration" "launchconfig" {
  name_prefix     = "launchconfig"
  image_id        = var.AMI_ID
  instance_type   = var.INSTANCE_TYPE
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.allow-ssh.id, aws_security_group.nginx.id, aws_security_group.elb-securitygroup.id]
  user_data       = data.template_cloudinit_config.config.rendered
  #user_data       = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
  #user_data       = "#!/bin/bash\napt-get update\napt-get -y install nginx\nservice nginx start"
#  user_data       = <<EOF
#!/bin/bash
#apt-get update
#apt-get -y install nginx
#service nginx start
#EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling" {
  name                      = "autoscaling"
  vpc_zone_identifier       = var.PUBLIC_SUBNETS
  launch_configuration      = aws_launch_configuration.launchconfig.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.elb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "${var.APP}-${var.ENV}-instance"
    propagate_at_launch = true
  }
}

