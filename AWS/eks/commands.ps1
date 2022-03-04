# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out eks.plan -var-file eks.tfvars
terraform plan -out eks.tfplan

# start terraform script 
terraform apply -auto-approve eks.tfplan

# destroy provisioned resource
# terraform plan -destroy -out eks.plan -var-file eks.tfvars
terraform plan -destroy -out eks.tfplan