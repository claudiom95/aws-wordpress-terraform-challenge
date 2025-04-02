variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID to attach to the EC2 instance"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "db_host" {
  description = "RDS database endpoint"
  type        = string
}

variable "db_name" {
  description = "WordPress database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "instance_name" {
  description = "Logical name of the instance (used for user_data)"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP with the instance"
  type        = bool
  default     = false
}