variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  default     = "ami-0c101f26f147fa7fd" # Amazon Linux 2023
}