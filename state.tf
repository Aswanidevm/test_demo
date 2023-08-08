terraform {
  backend "s3" {
    bucket = "myprojecdevops"
    key    = "prod/infra/terraform.tfstate"
    region = "us-east-1"

  }
}
