module "cloudwatch" {
  source           = "./modules/cloudwatch"
  ec2_instance_ids = [module.ec2_blue.instance_id, module.ec2_green.instance_id]
  rds_instance_ids = [module.rds_blue.db_instance_id, module.rds_green.db_instance_id]
}
