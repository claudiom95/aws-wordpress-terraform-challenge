output "vpc_id" {
  value = aws_vpc.wordpress_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_ids" {
  value = [aws_subnet.private_subnet.id, aws_subnet.private_subnet_2.id]
}

output "public_sg_id" {
  value = aws_security_group.public_sg.id
}

output "private_sg_id" {
  value = aws_security_group.private_sg.id
}