variable "vpc_id" {
  description = "The VPC ID where the ALB will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "wordpress-alb"
}

variable "security_group_ids" {
  description = "Security group ID to attach to the ALB"
  type        = list(string)

}

variable "ec2_blue_instance_id" {
  description = "ID of the blue EC2 instance"
  type        = string
}

variable "ec2_green_instance_id" {
  description = "ID of the green EC2 instance"
  type        = string
}

variable "active_environment" {
  description = "Which environment (blue or green) should receive traffic"
  type        = string
  default     = "blue"
}