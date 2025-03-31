variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr_2" {
  type = string
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "availability_zone_1" {
  type = string
}

variable "availability_zone_2" {
  type = string
}