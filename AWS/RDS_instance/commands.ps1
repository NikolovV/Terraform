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
# terraform plan -out rds.plan -var-file rds.tfvars
terraform plan -out rds.tfplan

# start terraform script 
terraform apply -auto-approve rds.tfplan

# destroy provisioned resource
# terraform plan -destroy -out rds.plan -var-file rds.tfvars
terraform plan -destroy -out rds.tfplan