output "rds_endpoint" {
  description = "RDS MySQL Endpoint"
  value       = aws_db_instance.mysql_db.endpoint
}
