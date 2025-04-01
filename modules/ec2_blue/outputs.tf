output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.wordpress_blue.id
}

output "public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.wordpress_blue.public_ip
}

output "private_ip" {
  description = "The private IP of the EC2 instance"
  value       = aws_instance.wordpress_blue.private_ip
}

output "instance_arn" {
  description = "The ARN of the EC2 instance"
  value       = aws_instance.wordpress_blue.arn
}