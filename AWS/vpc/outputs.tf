output "vpc_ip_out" {
  description = "The association ID for the IPv6 CIDR block"
  value       = aws_vpc.terr_vpc.ipv6_association_id
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.terr_vpc.id
}

output "subnet_pr_ip_out" {
  description = "The association ID for the IPv6 CIDR block."
  value       = aws_subnet.terr-public-sb.ipv6_cidr_block_association_id
}

output "subnet_pub_ip_out" {
  description = "The association ID for the IPv6 CIDR block."
  value       = aws_subnet.terr-private-sb.ipv6_cidr_block_association_id
}

