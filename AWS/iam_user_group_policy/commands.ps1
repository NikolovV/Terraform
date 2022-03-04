# initialaze proceders
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out iam.plan -var-file iam.tfvars
terraform plan -out iam.tfplan

# start terraform script 
terraform apply -auto-approve iam.tfplan

# destroy provisioned resource
# terraform plan -destroy -out iam.plan -var-file iam.tfvars
terraform plan -destroy -out iam.tfplan