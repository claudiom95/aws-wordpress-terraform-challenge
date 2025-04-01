module "ec2_blue" {
  source               = "./modules/ec2_blue"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_ids[0]
  security_group_ids   = [module.vpc.public_sg_id]
  iam_instance_profile = module.cloudwatch.iam_instance_profile_name
  db_username          = var.db_username
  db_name              = var.db_name
  db_password          = local.db_password
  db_host              = module.rds.endpoint
}

module "ec2_green" {
  source               = "./modules/ec2_green"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_ids[1]
  security_group_ids   = [module.vpc.public_sg_id]
  iam_instance_profile = module.cloudwatch.iam_instance_profile_name
  db_username          = var.db_username
  db_name              = var.db_name
  db_password          = local.db_password
  db_host              = module.rds.endpoint
}