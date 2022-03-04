output "eip-ip" {
  description = "Elastic IP address"
  value       = aws_eip.terr-ec2-eip.public_ip
}

output "aws-instance-pip" {
  description = "EC2 public IP"
  value = aws_instance.terr-ec2.public_ip
}