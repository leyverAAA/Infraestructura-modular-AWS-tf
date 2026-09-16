output "vpc_id" {
  value       = aws_vpc.main.id
  description = "El ID de la VPC creada"
}

output "public_subnet_id" {
  value       = aws_subnet.public.id
  description = "El ID de la subred pública"
}

output "private_subnet_id" {
  value       = aws_subnet.private_1.id
  description = "El ID de la primera subred privada"
}

output "private_subnet_ids" {
  value       = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  description = "Lista de IDs de subredes privadas"
}