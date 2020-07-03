module "main-vpc" {
  source     = "../modules/vpc"
  ENV        = "itg"
  AWS_REGION = var.AWS_REGION
}

module "instances" {
  source         = "../modules/instances"
  AMI_ID 	 = var.AMI_ID
  ENV            = "itg"
  VPC_ID         = module.main-vpc.vpc_id
  PUBLIC_SUBNETS = module.main-vpc.public_subnets
}

