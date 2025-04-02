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

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP with the instance"
  type        = bool
  default     = false
}

variable "user_data" {
  description = "User data script to provision EC2 instance"
  type        = string
}