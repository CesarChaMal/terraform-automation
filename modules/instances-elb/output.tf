output "instance_public_ip" {
  value = aws_instance.instance.public_ip
}
output "ELB" {
  value = aws_elb.elb.dns_name
}
