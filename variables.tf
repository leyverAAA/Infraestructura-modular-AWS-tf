variable "region" {
  type        = string
  description = "Región de AWS donde desplegaremos"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block para la VPC principal"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block para la subred pública"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block para la subred privada"
}

variable "private_subnet_cidr_2" {
  type        = string
  description = "CIDR block para la segunda subred privada (AZ distinta)"
}

variable "instance_type" {
  type        = string
  description = "Tipo de instancia de la EC2"
}

variable "environment" {
  type        = string
  description = "Nombre del entorno (dev, prod)"
  default     = "dev"
}

variable "db_password" {
  type        = string
  description = "Contraseña para el usuario administrador de la base de datos"
  sensitive   = true
}