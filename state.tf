terraform {
  backend "s3" {
    bucket = "my-terraform-state-saa"
    key = "global/s3/terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "s3-tf-table"
  }
}