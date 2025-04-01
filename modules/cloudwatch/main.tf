# Define a Role EC2 Can Assume
resource "aws_iam_role" "cloudwatch_agent_role" {
  name = "ec2-cloudwatch-agent-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Make Custom Policy with Least Privilege
resource "aws_iam_policy" "cloudwatch_least_privilege" {
  name        = "CloudWatchAgentLeastPrivilege"
  description = "Minimal IAM permissions for EC2 CloudWatch Agent"
  policy      = file("${path.module}/cloudwatch-policy.json")
}

# Attach Custom Policy
resource "aws_iam_policy_attachment" "cloudwatch_custom_attach" {
  name       = "cloudwatch-agent-custom-attachment"
  roles      = [aws_iam_role.cloudwatch_agent_role.name]
  policy_arn = aws_iam_policy.cloudwatch_least_privilege.arn
}

# Make Role Usable by EC2
resource "aws_iam_instance_profile" "cloudwatch_profile" {
  name = "ec2-cloudwatch-agent-profile"
  role = aws_iam_role.cloudwatch_agent_role.name
}

# Dashboard
resource "aws_cloudwatch_dashboard" "wordpress_dashboard" {
  dashboard_name = "wordpress-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      # EC2 CPU
      {
        type   = "metric",
        x      = 0,
        y      = 0,
        width  = 6,
        height = 6,
        properties = {
          title  = "EC2 CPU Usage (%)",
          view   = "timeSeries",
          region = "eu-west-3",
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", var.ec2_instance_id]
          ],
          period = 300,
          stat   = "Average"
        }
      },

      # RDS CPU
      {
        type   = "metric",
        x      = 6,
        y      = 0,
        width  = 6,
        height = 6,
        properties = {
          title  = "RDS CPU Utilization",
          view   = "timeSeries",
          region = "eu-west-3",
          metrics = [
            ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", var.rds_instance_id]
          ],
          period = 300,
          stat   = "Average"
        }
      },

      # RDS Free Storage
      {
        type   = "metric",
        x      = 0,
        y      = 6,
        width  = 6,
        height = 6,
        properties = {
          title  = "RDS Free Storage (MB)",
          view   = "timeSeries",
          region = "eu-west-3",
          metrics = [
            ["AWS/RDS", "FreeStorageSpace", "DBInstanceIdentifier", var.rds_instance_id]
          ],
          period = 300,
          stat   = "Average"
        }
      },

      # EC2 Network In
      {
        type   = "metric",
        x      = 6,
        y      = 6,
        width  = 6,
        height = 6,
        properties = {
          title  = "EC2 Network In",
          view   = "timeSeries",
          region = "eu-west-3",
          metrics = [
            ["AWS/EC2", "NetworkIn", "InstanceId", var.ec2_instance_id]
          ],
          period = 300,
          stat   = "Sum"
        }
      },
    ]
  })
}