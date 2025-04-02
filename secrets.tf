module "secrets_blue" {
  source      = "./modules/secrets"
  db_password = var.db_password_blue
  secret_name = "wordpress-db-password-blue"
}

module "secrets_green" {
  source      = "./modules/secrets"
  db_password = var.db_password_green
  secret_name = "wordpress-db-password-green"
}

locals {
  db_password_blue  = module.secrets_blue.db_password
  db_password_green = module.secrets_green.db_password
}