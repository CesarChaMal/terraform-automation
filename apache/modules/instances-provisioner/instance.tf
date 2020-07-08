resource "aws_instance" "instance" {
  ami           = var.AMI_ID
  instance_type = var.INSTANCE_TYPE

  # the VPC subnet
  subnet_id = element(var.PUBLIC_SUBNETS, 0)

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id, aws_security_group.apache.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  provisioner "file" {
    source      = var.PATH_CONF
    destination = "/tmp"
  }

  provisioner "file" {
    source      = var.PATH_SCRIPT
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo sed -i -e 's/\r$//' /tmp/script.sh",  # Remove the spurious CR characters.
      "sudo /tmp/script.sh",
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  tags = {
    Name         = "${var.APP}-${var.ENV}-instance"
    Environmnent = var.ENV
    Application = var.APP
  }
}
