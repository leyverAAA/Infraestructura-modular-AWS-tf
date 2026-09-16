output "db_endpoint" {
  value       = aws_db_instance.main.endpoint
  description = "Endpoint (host:puerto) de conexion a la base de datos"
}