# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out etl_stfn.plan -var-file etl_stfn.tfvars
terraform plan -out etl_stfn.tfplan

# start terraform script 
terraform apply -auto-approve etl_stfn.tfplan

# destroy provisioned resource
# terraform plan -destroy -out etl_stfn.plan -var-file etl_stfn.tfvars
terraform plan -destroy -out etl_stfn.tfplan

