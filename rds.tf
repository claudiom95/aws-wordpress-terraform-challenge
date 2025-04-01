module "rds" {
  source                 = "./modules/rds"
  instance_class         = var.instance_class
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = local.db_password
  vpc_security_group_ids = [module.vpc.private_sg_id]
  subnet_ids             = module.vpc.private_subnet_ids
}