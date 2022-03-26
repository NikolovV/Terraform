# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out rest_api.plan -var-file rest_api.tfvars
terraform plan -out rest_api.tfplan

# start terraform script 
terraform apply -auto-approve rest_api.tfplan

# destroy provisioned resource
# terraform plan -destroy -out rest_api.plan -var-file rest_api.tfvars
terraform plan -destroy -out rest_api.tfplan

