#!/bin/bash

AWS_REGION="eu-central-1"
S3_BUCKET=`aws s3 ls --region $AWS_REGION | grep terraform-state-apache-prod | tail -n1 |cut -d ' ' -f3`
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
