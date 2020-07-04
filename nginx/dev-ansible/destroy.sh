#!/bin/bash
AWS_REGION="eu-central-1"
S3_BUCKET=`aws s3 ls --region $AWS_REGION | grep terraform-state-dev | tail -n1 |cut -d ' ' -f3`
aws s3 rm s3://${S3_BUCKET} --region $AWS_REGION --recursive
terraform destroy -auto-approve
