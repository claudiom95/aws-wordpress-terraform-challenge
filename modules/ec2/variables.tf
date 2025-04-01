variable "ami_id" {
  description = "AMI to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for WordPress EC2"
  type = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet to launch the EC2 instance into"
  type        = string
}

variable "security_group_ids" {
  description = "Security groups to attach"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "db_password" {
  description = "MySQL DB password (for WordPress)"
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "MySQL DB host"
  type        = string
}

variable "db_name" {
  type        = string
  description = "The name of the WordPress database"
}

variable "db_username" {
  type        = string
  description = "The username for the WordPress database"
}