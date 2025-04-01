module "ec2" {
  source               = "./modules/ec2"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_id
  security_group_ids   = [module.vpc.public_sg_id]
  iam_instance_profile = module.cloudwatch.iam_instance_profile_name
  db_password          = local.db_password
  db_host              = module.rds.endpoint
  db_name              = var.db_name
  db_username          = var.db_username
}