# # S3 Bucket for Terraform State
# resource "aws_s3_bucket" "tf_state" {
#   bucket        = "wordpress-terraform-state-claudio"
#   force_destroy = true
# }

# resource "aws_s3_bucket_versioning" "tf_state_versioning" {
#   bucket = aws_s3_bucket.tf_state.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_encryption" {
#   bucket = aws_s3_bucket.tf_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }