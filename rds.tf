module "rds" {
  source                 = "./modules/rds"
  instance_class         = "db.t3.micro"
  db_name                = "wordpress_db"
  db_username            = "claudio"
  db_password            = local.db_password
  vpc_security_group_ids = [module.vpc.private_sg_id]
  subnet_ids             = module.vpc.private_subnet_ids
}