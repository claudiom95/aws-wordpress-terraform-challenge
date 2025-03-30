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
            ["AWS/EC2", "CPUUtilization", "InstanceId", aws_instance.wordpress.id]
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
            ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", aws_db_instance.wordpress_db.id]
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
            ["AWS/RDS", "FreeStorageSpace", "DBInstanceIdentifier", aws_db_instance.wordpress_db.id]
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
            ["AWS/EC2", "NetworkIn", "InstanceId", aws_instance.wordpress.id]
          ],
          period = 300,
          stat   = "Sum"
        }
      },
    ]
  })
}