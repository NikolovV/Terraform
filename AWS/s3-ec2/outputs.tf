output "aws-instance-pip" {
  description = "EC2 public IP"
  value       = aws_instance.ec2.public_ip
}