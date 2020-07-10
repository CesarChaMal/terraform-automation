##resource "aws_s3_bucket" "terraform-state" {
##  bucket = "terraform-state-${var.APP}-${var.ENV}-a286129"
##  acl    = "private"
##  force_destroy = true
## 
##  versioning {
##    enabled = true
##  }
##
##  lifecycle {
##    create_before_destroy = true
##  }
##  
##  tags = {
##    Name = "Terraform state"
##  }
##}
##
