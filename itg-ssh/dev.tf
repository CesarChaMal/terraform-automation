module "main-vpc" {
  source     = "../modules/vpc"
  ENV        = "itg"
  AWS_REGION = var.AWS_REGION
}

module "instances-provisioner" {
  source         = "../modules/instances-provisioner"
  AMI_ID		 = lookup(var.AMIS, var.AWS_REGION)
  ENV            = "itg"
  VPC_ID         = module.main-vpc.vpc_id
  PUBLIC_SUBNETS = module.main-vpc.public_subnets
}

