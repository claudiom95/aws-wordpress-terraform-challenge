# General variables
variable "region" {
  type    = string
  default = "eu-west-3"
}

# VPC variables
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_2" {
  description = "CIDR block for the second public subnet"
  type        = string
  default     = "10.0.4.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_2" {
  description = "CIDR block for the second private subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for the VPC"
  type        = bool
  default     = true
}

variable "availability_zone_1" {
  description = "Availability zone for the first private subnet"
  type        = string
  default     = "eu-west-3a"
}

variable "availability_zone_2" {
  description = "Availability zone for the second private subnet"
  type        = string
  default     = "eu-west-3b"
}

# EC2 Variables
variable "ami_id" {
  description = "AMI ID to launch the WordPress instance"
  type        = string
  default     = "ami-0ff71843f814379b3"
}

variable "instance_type" {
  description = "EC2 instance type for WordPress"
  type        = string
  default     = "t2.micro"
}

# RDS Variables
variable "instance_class" {
  type        = string
  description = "The RDS instance class"
  default     = "db.t3.micro"
}

variable "db_name" {
  type        = string
  description = "The name of the WordPress database"
  default     = "wordpress_db"
}

variable "db_username" {
  type        = string
  description = "The username for the WordPress database"
  default     = "claudio"
}

variable "db_password" {
  description = "The password for the blue WordPress MySQL database"
  type        = string
  sensitive   = true
}

variable "db_password_green" {
  description = "DB password for the green RDS instance"
  type        = string
  sensitive   = true
}

# ALB Variables
variable "active_environment" {
  description = "The environment to route traffic to (blue or green)"
  type        = string
  default     = "blue"
}