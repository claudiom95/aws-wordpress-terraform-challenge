variable "ec2_instance_ids" {
  description = "List of EC2 instance IDs to include in the dashboard"
  type        = list(string)
}

variable "rds_instance_ids" {
  type        = list(string)
  description = "List of RDS instance IDs for dashboard"
}