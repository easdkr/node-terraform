provider "aws" {
  region = var.aws_region
}

terraform {
  cloud {
    organization = "june-develop"

    workspaces {
      name = "node-terraform"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.0"
}
