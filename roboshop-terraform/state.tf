terraform {
    backend "s3" {
        bucket = "roboshop-terraform"
        key = "Dev/terraform.tfstate"
        region = "us-east-1"
    }
}