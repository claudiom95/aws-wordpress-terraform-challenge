output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.wordpress_alb.dns_name
}

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.wordpress_alb.arn
}

output "target_group_blue_arn" {
  description = "The ARN of the Blue target group"
  value       = aws_lb_target_group.blue.arn
}

output "target_group_green_arn" {
  description = "The ARN of the Green target group"
  value       = aws_lb_target_group.green.arn
}