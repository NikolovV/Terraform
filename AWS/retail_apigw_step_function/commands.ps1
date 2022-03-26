# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out retail.plan -var-file retail.tfvars
terraform plan -out retail.tfplan

# start terraform script 
terraform apply -auto-approve retail.tfplan
terraform apply -auto-approve

# destroy provisioned resource
# terraform plan -destroy -out retail.plan -var-file retail.tfvars
terraform plan -destroy -out retail.tfplan

