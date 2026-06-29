# outputs.tf — Important values jo baad mein chahiye

output "ec2_public_ip" {
  description = "EC2 instance public IP"
  value       = module.ec2.public_ip
}

output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.endpoint
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}
