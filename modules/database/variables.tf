variable "vpc_id" {
  type        = string
  description = "ID de la VPC principal"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Lista de subredes privadas para el DB Subnet Group"
}

variable "web_sg_id" {
  type        = string
  description = "ID del Security Group del servidor web"
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_password" {
  type      = string
  sensitive = true # Evita que la contraseña se imprima en texto plano en la consola
}

variable "environment" {
  type    = string
  default = "dev"
}