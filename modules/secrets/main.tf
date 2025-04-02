# Creates an empty secret in SM
resource "aws_secretsmanager_secret" "wordpress_db_password" {
  name        = var.secret_name
  description = "MySQL database password for WordPress"
}

# Adds a db_password for the secret created
resource "aws_secretsmanager_secret_version" "wordpress_db_password_version" {
  secret_id = aws_secretsmanager_secret.wordpress_db_password.id
  secret_string = jsonencode({
    password = var.db_password
  })
}

# Use password in Terraform
data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.wordpress_db_password.id

  depends_on = [
    aws_secretsmanager_secret_version.wordpress_db_password_version
  ]
}