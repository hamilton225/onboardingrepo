terraform {
  backend "s3" {
    bucket = "backend-bucket-ob"
    key    = "vpc/terraform.tfstate"
    region = "eu-west-1"
  }
}
