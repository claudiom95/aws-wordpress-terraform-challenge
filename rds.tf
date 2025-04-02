module "rds_blue" {
  source                 = "./modules/rds"
  instance_class         = var.instance_class
  identifier             = "wordpress-db-instance-blue"
  name_suffix            = "blue"
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = local.db_password_blue
  vpc_security_group_ids = [module.vpc.private_sg_id]
  subnet_ids             = module.vpc.private_subnet_ids
}

module "rds_green" {
  source                 = "./modules/rds"
  instance_class         = var.instance_class
  identifier             = "wordpress-db-instance-green"
  name_suffix            = "green"
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = local.db_password_green
  vpc_security_group_ids = [module.vpc.private_sg_id]
  subnet_ids             = module.vpc.private_subnet_ids
}