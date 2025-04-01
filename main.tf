module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_cidr   = var.private_subnet_cidr
  private_subnet_cidr_2 = var.private_subnet_cidr_2
  vpc_name              = var.vpc_name
  enable_dns_hostnames  = var.enable_dns_hostnames
  availability_zone_1   = var.availability_zone_1
  availability_zone_2   = var.availability_zone_2
}

module "ec2" {
  source               = "./modules/ec2"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_id
  security_group_ids   = [module.vpc.public_sg_id]
  iam_instance_profile = aws_iam_instance_profile.cloudwatch_profile.name
  db_password          = local.db_password
  db_host              = module.rds.endpoint
  db_name              = var.db_name
  db_username          = var.db_username
}

module "rds" {
  source                 = "./modules/rds"
  instance_class         = "db.t3.micro"
  db_name                = "wordpress_db"
  db_username            = "claudio"
  db_password            = local.db_password
  vpc_security_group_ids = [module.vpc.private_sg_id]
  subnet_ids             = module.vpc.private_subnet_ids
}
