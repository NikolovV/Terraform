## AWS auto scaling EC2 module
> Auto scaling configuration, load balancer and auto Scaling group
---
### Input variable
| variable | type |
| ------ | ------ |
| aws_project_name | string |
| resource_tags | map(string) |
| avlz | list(string) |
| subnets | list(string) |
| elb_security_groups | list(string) |
| web_serv_security_groups | list(string) |
| web_image_id | string |
| web_instance_type | string |
| web_desired_capacity | number |
| web_max_size | number |
| web_min_size | number |
### Output variable
| variable | description |
| ------ | ------ |
| dns_name | Load balancer DNS name. |