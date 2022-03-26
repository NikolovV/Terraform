#!/bin/bash
yum update -y
yum install python3
yum -y install python-pip
pip install awscli
echo "Some sample text file" > sample.txt
aws s3 cp sample.txt s3://ec2-bucket-0101