resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-state-a286129"
  acl    = "private"

  tags = {
    Name = "Terraform state"
  }
}

