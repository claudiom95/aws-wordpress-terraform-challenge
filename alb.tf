module "alb" {
  source                = "./modules/alb"
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.public_subnet_ids
  security_group_ids    = [module.vpc.public_sg_id]
  ec2_blue_instance_id  = module.ec2_blue.instance_id
  ec2_green_instance_id = module.ec2_green.instance_id
  active_environment    = var.active_environment
}