#!/bin/bash
set -ex

ARTIFACT=`packer build -machine-readable packer.json | awk -F, '$0 ~/artifact,0,id/ {print $6}'`
echo "packer output:"
cat packer.json

AMI_ID=`echo $ARTIFACT | cut -d ':' -f2`
echo "AMI ID: ${AMI_ID}"

echo "writing amivar-apache-itg.tf and uploading it to s3"
echo 'variable "AMI_ID" { default = "'${AMI_ID}'" }' > amivar-itg.tf

AWS_REGION="eu-central-1"
S3_BUCKET=`aws s3 ls --region $AWS_REGION | grep terraform-state-apache-itg | tail -n1 |cut -d ' ' -f3`
if [ -n "$S3_BUCKET" ]; then
	sed -i 's/#//g' backend.tf
	sed -i -e 's/^/#/' s3.tf
	terraform init -force-copy
	terraform state rm aws_s3_bucket.terraform-state
else
	rm -rf .terraform
	sed -i -e 's/^/#/' backend.tf
	sed -i 's/#//g' s3.tf
fi

terraform init -force-copy && terraform apply -auto-approve
terraform init -force-copy
./info_instance.sh