variable "db_password" {
  description = "The password for the WordPress MySQL database"
  type        = string
  sensitive   = true
}

variable "secret_name" {
  type        = string
  description = "The name of the Secrets Manager secret"
}