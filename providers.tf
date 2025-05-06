provider "aws" {
  region = var.target_account_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.97.0"  # or latest supported
    }
  }
}
