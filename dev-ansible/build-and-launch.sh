#!/bin/bash
set -ex

AWS_REGION="eu-central-1"

ARTIFACT=`packer build -machine-readable packer.json | awk -F, '$0 ~/artifact,0,id/ {print $6}'`
echo "packer output:"
cat packer.json

AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`
echo "AMI ID: ${AMI_ID}"

echo "writing amivar.tf and uploading it to s3"
echo 'variable "AMI_ID" { default = "'${AMI_ID}'" }' > amivar.tf

S3_BUCKET=`aws s3 ls --region $AWS_REGION | grep terraform-state |tail -n1 |cut -d ' ' -f3`
aws s3 cp amivar.tf s3://${S3_BUCKET}/amivar.tf --region $AWS_REGION

terraform init && terraform apply -auto-approve
sed -i 's/#//g' backend.tf
terraform init