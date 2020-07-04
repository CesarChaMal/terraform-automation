resource "aws_elb" "elb" {
  name            = "elb-${var.ENV}"
  subnets         = var.PUBLIC_SUBNETS
  security_groups = [aws_security_group.allow-ssh.id, aws_security_group.nginx.id, aws_security_group.elb-securitygroup.id]
  
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  
  tags = {
    Name         = "elb-${var.ENV}"
    Environmnent = var.ENV
  }
}

