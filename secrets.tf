module "secrets" {
  source      = "./modules/secrets"
  db_password = var.db_password
}

locals {
  db_password = module.secrets.db_password
}