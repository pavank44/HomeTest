output "alb_name" {
  description = "The ARN suffix of the ALB"
  value       = join("", aws_lb.default.*.name)
}

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = join("", aws_lb.default.*.arn)
}

output "alb_dns_name" {
  description = "DNS name of ALB"
  value       = join("", aws_lb.default.*.dns_name)
}

output "security_group_id" {
  description = "The security group ID of the ALB"
  value       = join("", aws_security_group.default.*.id)
}

