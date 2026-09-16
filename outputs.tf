output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID de la Subred Pública"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "ID de la Subred Privada"
  value       = module.vpc.private_subnet_id
}
output "web_public_ip" {
  description = "IP pública de la aplicación web"
  value       = module.compute.public_ip
}

output "database_endpoint" {
  description = "Endpoint privado de conexion a MySQL"
  value       = module.database.db_endpoint
}