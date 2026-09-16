output "public_ip" {
  value       = aws_instance.web_server.public_ip
  description = "Dirección IP pública del servidor Web"
}

output "web_sg_id" {
  value       = aws_security_group.web_sg.id
  description = "ID del Security Group del servidor web"
}