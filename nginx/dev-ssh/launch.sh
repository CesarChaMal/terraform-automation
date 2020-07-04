#!/bin/bash
terraform init && terraform apply -auto-approve

AWS_REGION="eu-central-1"
S3_BUCKET=`aws s3 ls --region $AWS_REGION | grep terraform-state-dev | tail -n1 |cut -d ' ' -f3`
aws s3 cp amivar-dev.tf s3://${S3_BUCKET}/amivar-dev.tf --region $AWS_REGION
sed -i 's/#//g' backend.tf

terraform init -force-copy
