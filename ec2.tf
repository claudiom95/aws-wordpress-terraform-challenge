module "ec2_blue" {
  source                      = "./modules/ec2"
  ami_id                      = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.public_subnet_ids[0]
  security_group_id           = [module.vpc.public_sg_id]
  iam_instance_profile        = module.cloudwatch.iam_instance_profile_name
  associate_public_ip_address = true

  user_data = templatefile("${path.root}/user_data.sh", {
    db_host     = module.rds.endpoint,
    db_name     = var.db_name,
    db_username = var.db_username,
    db_password = var.db_password,
    instance    = "blue"
  })
}

module "ec2_green" {
  source                      = "./modules/ec2"
  ami_id                      = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.public_subnet_ids[1]
  security_group_id           = [module.vpc.public_sg_id]
  iam_instance_profile        = module.cloudwatch.iam_instance_profile_name
  associate_public_ip_address = true

  user_data = templatefile("${path.root}/user_data.sh", {
    db_host     = module.rds.endpoint,
    db_name     = var.db_name,
    db_username = var.db_username,
    db_password = var.db_password,
    instance    = "green"
  })
}