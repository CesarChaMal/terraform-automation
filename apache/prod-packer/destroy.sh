#!/bin/bash
terraform init -force-copy
terraform state rm aws_s3_bucket.terraform-state
terraform destroy -auto-approve
#rm -rf .terraform/

AWS_REGION="eu-central-1"
S3_BUCKET=`aws s3 ls --region $AWS_REGION | grep terraform-state-apache-prod | tail -n1 |cut -d ' ' -f3`
#aws s3 cp s3://${S3_BUCKET}/terraform.tfstate --region $AWS_REGION terraform.tfstate
aws s3 rm s3://${S3_BUCKET} --region $AWS_REGION --recursive
./info_instance.sh