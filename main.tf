terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "us-east-1"
  shared_config_files      = ["/Users/sharmilas/.aws/config"]
  shared_credentials_files = ["/Users/sharmilas/.aws/credentials"]
  profile                  = "sharmi"
}
