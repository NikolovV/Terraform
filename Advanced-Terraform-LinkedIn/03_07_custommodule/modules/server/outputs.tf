# Output
output "instance_dns" {
  value = aws_instance.nodejs.*.public_dns
}