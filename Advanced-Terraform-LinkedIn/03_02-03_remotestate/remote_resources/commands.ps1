# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out s3_backend.plan -var-file s3_backend.tfvars
terraform plan -out s3_backend.tfplan

# start terraform script 
terraform apply -auto-approve s3_backend.tfplan

# destroy provisioned resource
# terraform plan -destroy -out s3_backend.plan -var-file s3_backend.tfvars
terraform plan -destroy -out s3_backend.tfplan