resource "aws_instance" "wordpress_blue" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true
  iam_instance_profile        = var.iam_instance_profile

  user_data = templatefile("${path.module}/user_data.sh", {
    db_password = var.db_password
    db_host     = var.db_host
    db_name     = var.db_name
    db_username = var.db_username
  })
}