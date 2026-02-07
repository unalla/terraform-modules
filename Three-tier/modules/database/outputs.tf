output "db_instance_endpoint" {
  description = "The connection endpoint for the database"
  value       = aws_db_instance.postgres.endpoint
}

output "db_instance_address" {
  description = "The hostname of the RDS instance"
  value       = aws_db_instance.postgres.address
}

output "db_instance_port" {
  description = "The port the database is listening on"
  value       = aws_db_instance.postgres.port
}

output "db_security_group_id" {
  description = "The ID of the security group for the database"
  value       = aws_security_group.db_sg.id
}