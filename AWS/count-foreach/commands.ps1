# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create workspace
terraform workspace new DEV
terraform workspace new QA
terraform workspace new STAGE
terraform workspace new PROD

# list workspace
terraform workspace list

# change workspace
terraform workspace select DEV

# create terraform plan
# terraform plan -out count_foreach.plan -var-file count_foreach.tfvars
terraform plan -out count_foreach.tfplan

# start terraform script 
terraform apply -auto-approve count_foreach.tfplan

# destroy provisioned resource
# terraform plan -destroy -out count_foreach.plan -var-file count_foreach.tfvars
terraform plan -destroy -out count_foreach.tfplan