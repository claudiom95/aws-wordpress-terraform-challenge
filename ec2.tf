resource "aws_instance" "wordpress" {
  ami                         = "ami-0ff71843f814379b3"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.cloudwatch_profile.name
  user_data = templatefile("${path.module}/user_data.sh", {
    db_password = local.db_password
    db_host     = aws_db_instance.wordpress_db.endpoint
  })
}