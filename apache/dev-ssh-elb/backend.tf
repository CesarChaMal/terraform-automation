terraform {
  backend "s3" {
    bucket = "terraform-state-apache-dev-a286129"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}
