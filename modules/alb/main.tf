resource "aws_lb" "wordpress_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "blue" {
  name     = "blue-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "green" {
  name     = "green-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.wordpress_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = local.active_target_group_arn
  }
}

resource "aws_lb_target_group_attachment" "blue_instance" {
  target_group_arn = aws_lb_target_group.blue.arn
  target_id        = var.ec2_blue_instance_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "green_instance" {
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = var.ec2_green_instance_id
  port             = 80
}

locals {
  active_target_group_arn = var.active_environment == "blue" ? aws_lb_target_group.blue.arn : aws_lb_target_group.green.arn
}