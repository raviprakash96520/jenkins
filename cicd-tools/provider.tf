terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = "roboshop-infra-state-dev"
    key            = "expense-cicd"
    region         = "us-east-1"
    dynamodb_table = "jenkins-locking"
  }
}

provider "aws" {
  region = "us-east-1"
}
