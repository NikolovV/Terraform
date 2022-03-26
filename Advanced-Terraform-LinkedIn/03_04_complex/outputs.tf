# Output
output "instance-ip" {
  value = module.ec2_cluster.public_ip
}