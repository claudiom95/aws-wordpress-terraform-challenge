output "db_instance_id" {
  value = aws_db_instance.wordpress_db.id
}

output "endpoint" {
  value = aws_db_instance.wordpress_db.endpoint
}