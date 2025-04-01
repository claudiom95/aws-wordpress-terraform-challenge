module "cloudwatch" {
  source          = "./modules/cloudwatch"
  ec2_instance_id = module.ec2_blue.instance_id
  rds_instance_id = module.rds.db_instance_id
}