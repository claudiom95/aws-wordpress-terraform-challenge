terraform {
  backend "s3" {
    bucket  = "wordpress-terraform-state-claudio"
    key     = "wordpress/terraform.tfstate"
    region  = "eu-west-3"
    encrypt = true
  }
}