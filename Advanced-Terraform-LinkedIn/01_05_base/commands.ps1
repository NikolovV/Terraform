# Create AWS key-pair for SSH connection to the instance.
# MAC/Linux
aws ec2 create-key-pair --key-name ec2-vpc --query 'KeyMaterial' --output text > ec2-vpc.ppk

# Windows
aws ec2 create-key-pair --key-name ec2-vpc --query 'KeyMaterial' --output text | out-file -encoding ascii -filepath ec2-vpc.ppk

# Initialize
terraform init

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out autoscaling.plan -var-file autoscaling.tfvars
terraform plan -out vpc-ec2.tfplan

# start terraform script 
terraform apply -auto-approve vpc-ec2.tfplan

# destroy provisioned resource
# terraform plan -destroy -out autoscaling.plan -var-file autoscaling.tfvars
terraform plan -destroy -out vpc-ec2.tfplan