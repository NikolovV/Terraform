# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out s3_website.plan -var-file s3_website.tfvars
terraform plan -out s3_website.tfplan

# start terraform script 
terraform apply -auto-approve s3_website.tfplan

# Uploud files to AWS S3
aws s3 cp modules/s3-static-website/www/ s3://$(terraform output -raw website_bucket_name)/ --recursive

# destroy provisioned resource
# terraform plan -destroy -out s3_website.plan -var-file s3_website.tfvars
terraform plan -destroy -out s3_website.tfplan