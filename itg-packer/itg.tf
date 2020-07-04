module "main-vpc" {
  source     = "../modules/vpc"
  ENV        = var.ENV
  AWS_REGION = var.AWS_REGION
}

module "instances" {
  source         = "../modules/instances"
  AMI_ID 	 	 = var.AMI_ID
  ENV            = var.ENV
  VPC_ID         = module.main-vpc.vpc_id
  PUBLIC_SUBNETS = module.main-vpc.public_subnets
}

