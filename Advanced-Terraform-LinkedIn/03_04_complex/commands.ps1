# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out vpc-ec2.plan -var-file vpc-ec2.tfvars
terraform plan -out vpc-ec2.tfplan

# start terraform script 
terraform apply -auto-approve vpc-ec2.tfplan

# destroy provisioned resource
# terraform plan -destroy -out vpc-ec2.plan -var-file vpc-ec2.tfvars
terraform plan -destroy -out vpc-ec2.tfplan