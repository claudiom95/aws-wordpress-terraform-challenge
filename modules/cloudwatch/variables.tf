variable "ec2_instance_ids" {
  description = "List of EC2 instance IDs to include in the dashboard"
  type        = list(string)
}

variable "rds_instance_id" {
  type        = string
  description = "RDS instance ID for dashboard"
}