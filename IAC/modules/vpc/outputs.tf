output "vpc_id" {
  description = "Vpc"
  value       = aws_vpc.vpc.id
}

output "nat_gateway" {
  description = "Nat gateway ids"
  value       = aws_nat_gateway.nat[*].id
}

output "private_subnet_ids" {
  description = "Private subnet ids"
  value       = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  description = "Public subnet ids"
  value       = aws_subnet.public[*].id
}

output "public_route_table_ids" {
  value       = aws_route_table.public[*].id
  description = "A list of public route table ids."
}

output "private_route_table_ids" {
  value       = aws_route_table.private[*].id
  description = "A list of private route table ids."
}

output "vpc_default_security_group_id" {
  value       = aws_vpc.vpc.default_security_group_id
  description = "Default Sg"
}
