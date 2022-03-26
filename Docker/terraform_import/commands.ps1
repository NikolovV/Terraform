# Create docker container
docker run --name terraform-nginx --detach --publish 8080:80 nginx:latest

# Check container is running
docker ps --filter="name=terraform-nginx"

# Initialize
terraform init

# Docker container ID
docker inspect --format="{{.ID}}" terraform-nginx

# import container
terraform import docker_container.web $(docker inspect --format="{{.ID}}" terraform-nginx)

#verify that the container has been imported into your Terraform state
terraform show

# validate terraform script
terraform validate

# format terraform script
terraform fmt

# create terraform plan
# terraform plan -out docker_nginx.plan -var-file docker_nginx.tfvars
terraform plan -out docker_nginx.tfplan

# start terraform script 
terraform apply -auto-approve docker_nginx.tfplan

# destroy provisioned resource
# terraform plan -destroy -out docker_nginx.plan -var-file docker_nginx.tfvars
terraform plan -destroy -out docker_nginx.tfplan