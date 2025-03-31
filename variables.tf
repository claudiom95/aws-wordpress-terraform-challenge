# General variables
variable "region" {
  type    = string
  default = "eu-west-3"
}

# VPC variables
variable "vpc_name" {
  description = "Name of the VPC (used in tags)"
  type        = string
  default     = "wordpress-vpc"
}

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

# MySQL
variable "db_password" {
  description = "The password for the WordPress MySQL database"
  type        = string
  sensitive   = true
}