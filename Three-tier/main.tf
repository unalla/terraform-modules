
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Ensures you get updates but no breaking changes
    }
  }
}

provider "aws" {
  region = var.aws_region
  
  # Best Practice: Use default tags so every resource in every module 
  # is automatically tagged with the project name.
  default_tags {
    tags = {
      Project   = "Resilient-Three-Tier"
      ManagedBy = "Terraform"
    }
  }
}

module "vpc" {
  source = "./modules/networking"
  vpc_cidr = "10.0.0.0/16"
}

module "app_layers" {
  source     = "./modules/compute"
  vpc_id     = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  ami_id          = var.ami_id
}

module "db" {
  source          = "./modules/database"
  vpc_id          = module.vpc.vpc_id
  db_subnets      = module.vpc.private_subnets
  db_password     = var.db_password
  allowed_ingress_sg = module.app_layers.app_sg_id
}