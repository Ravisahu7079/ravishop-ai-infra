# variables.tf — Saari variables yahan

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "ravishop-ai"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "db_password" {
  description = "RDS Database password"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
