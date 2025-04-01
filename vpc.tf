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