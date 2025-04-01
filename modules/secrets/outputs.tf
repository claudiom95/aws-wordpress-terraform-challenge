output "db_password" {
  description = "Decoded DB password from Secrets Manager"
  value       = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string).password
  sensitive   = true
}