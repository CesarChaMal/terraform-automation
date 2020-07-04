#!/bin/bash
set -ex

terraform init && terraform apply -auto-approve

AWS_REGION="eu-central-1"
S3_BUCKET=`aws s3 ls --region $AWS_REGION | grep terraform-state |tail -n1 |cut -d ' ' -f3`
aws s3 cp amivar-prod.tf s3://${S3_BUCKET}/amivar-prod.tf --region $AWS_REGION
sed -i 's/#//g' backend.tf

terraform init