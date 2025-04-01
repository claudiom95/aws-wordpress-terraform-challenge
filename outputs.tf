output "blue_instance_public_ip" {
  value = module.ec2_blue.public_ip
}

output "green_instance_public_ip" {
  value = module.ec2_green.public_ip
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}