variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the entire VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the first public subnet (WordPress EC2 instance)"
}

variable "public_subnet_cidr_2" {
  type        = string
  description = "CIDR block for the second public subnet (WordPress EC2 instance)"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for the first private subnet (RDS)"
}

variable "private_subnet_cidr_2" {
  type        = string
  description = "CIDR block for the second private subnet (RDS)"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Whether to enable DNS hostnames in the VPC"
}

variable "availability_zone_1" {
  type        = string
  description = "Availability Zone for the first private subnet"
}

variable "availability_zone_2" {
  type        = string
  description = "Availability Zone for the second private subnet"
}