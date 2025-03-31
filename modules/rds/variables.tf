variable "instance_class" {
  type        = string
  description = "The RDS instance class (e.g., db.t3.micro)"
}

variable "db_name" {
  type        = string
  description = "The name of the WordPress database"
}

variable "db_username" {
  type        = string
  description = "The username for the WordPress database"
}

variable "db_password" {
  type        = string
  description = "The password for the WordPress database"
  sensitive   = true
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC security group IDs to assign to the RDS instance"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs to use for the RDS subnet group"
}