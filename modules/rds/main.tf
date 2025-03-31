resource "aws_db_instance" "wordpress_db" {
  allocated_storage               = 20
  storage_type                    = "gp2"
  instance_class                  = var.instance_class
  engine                          = "mysql"
  engine_version                  = "8.0.40"
  db_name                         = var.db_name
  username                        = var.db_username
  password                        = var.db_password
  identifier                      = "wordpress-db-instance"
  publicly_accessible             = false
  vpc_security_group_ids          = var.vpc_security_group_ids
  db_subnet_group_name            = aws_db_subnet_group.wordpress_db_subnet_group.name
  multi_az                        = false
  enabled_cloudwatch_logs_exports = ["error", "slowquery"]
  parameter_group_name            = aws_db_parameter_group.mysql_logs.name
}

resource "aws_db_subnet_group" "wordpress_db_subnet_group" {
  name       = "wordpress-db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_parameter_group" "mysql_logs" {
  name        = "wordpress-db-logs"
  family      = "mysql8.0"
  description = "Enable MySQL logs for CloudWatch"

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "long_query_time"
    value = "1"
  }

  parameter {
    name  = "general_log"
    value = "0"
  }

  parameter {
    name  = "log_output"
    value = "FILE"
  }
}