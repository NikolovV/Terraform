output "dns_name" {
  description = "Load balancer DNS name."
  value       = aws_elb.this.dns_name
}