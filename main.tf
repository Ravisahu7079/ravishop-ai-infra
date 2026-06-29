# main.tf — Entry point for Terraform

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region
}

# IAM Module — Pehle banao
module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
  environment  = var.environment
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  project_name = var.project_name
  environment  = var.environment
}

# EC2 Module
module "ec2" {
  source = "./modules/ec2"

  project_name         = var.project_name
  environment          = var.environment
  vpc_id               = module.vpc.vpc_id
  public_subnet_id     = module.vpc.public_subnet_id
  instance_type        = var.instance_type
  iam_instance_profile = module.iam.instance_profile_name
}

# RDS Module
module "rds" {
  source = "./modules/rds"

  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  db_password        = var.db_password
}
