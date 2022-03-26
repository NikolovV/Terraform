output "dns_name" {
  description = "Load balancer DNS name."
  value       = module.autoscaling_ec2.dns_name
}