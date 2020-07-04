#!/bin/bash
set -ex

ARTIFACT=`packer build -machine-readable packer.json | awk -F, '$0 ~/artifact,0,id/ {print $6}'`
echo "packer output:"
cat packer.json

AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`
echo "AMI ID: ${AMI_ID}"

echo "writing amivar-dev.tf and uploading it to s3"
echo 'variable "AMI_ID" { default = "'${AMI_ID}'" }' > amivar-dev.tf

terraform init && terraform apply -auto-approve

AWS_REGION="eu-central-1"
S3_BUCKET=`aws s3 ls --region $AWS_REGION | grep terraform-state-dev |tail -n1 |cut -d ' ' -f3`
aws s3 cp amivar-dev.tf s3://${S3_BUCKET}/amivar-dev.tf --region $AWS_REGION
sed -i 's/#//g' backend.tf

terraform init
