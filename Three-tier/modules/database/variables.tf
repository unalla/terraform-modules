variable "vpc_id" {
  type = string
}

variable "db_subnets" {
  type = list(string)
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "allowed_ingress_sg" {
  description = "The security group ID of the API layer allowed to access the DB"
  type        = string
}