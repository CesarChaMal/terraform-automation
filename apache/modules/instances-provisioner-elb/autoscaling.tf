resource "aws_launch_configuration" "launchconfig" {
  name_prefix     = "launchconfig"
  image_id        = var.AMI_ID
  instance_type   = var.INSTANCE_TYPE
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.allow-ssh.id, aws_security_group.apache.id, aws_security_group.elb-securitygroup.id]
  user_data       = data.template_cloudinit_config.config.rendered
  #user_data       = template_cloudinit_config.config.rendered
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

