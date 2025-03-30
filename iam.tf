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

# Attach a Prebuilt Policy
resource "aws_iam_role_policy_attachment" "cloudwatch_attach" {
  role       = aws_iam_role.cloudwatch_agent_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Make Role Usable by EC2
resource "aws_iam_instance_profile" "cloudwatch_profile" {
  name = "ec2-cloudwatch-agent-profile"
  role = aws_iam_role.cloudwatch_agent_role.name
}
