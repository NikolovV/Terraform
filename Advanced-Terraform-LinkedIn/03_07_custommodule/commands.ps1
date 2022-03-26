# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out ec2.plan -var-file ec2.tfvars
terraform plan -out ec2.tfplan

# start terraform script 
terraform apply -auto-approve ec2.tfplan

# destroy provisioned resource
# terraform plan -destroy -out ec2.plan -var-file ec2.tfvars
terraform plan -destroy -out ec2.tfplan