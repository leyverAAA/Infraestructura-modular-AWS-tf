variable "vpc_cidr" {
  type        = string
  description = "Rango de IPs CIDR principal para la VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "Rango de IPs para la subred pública (Servidor Web)"
}

variable "private_subnet_cidr" {
  type        = string
  description = "Rango de IPs para la primera subred privada (Base de Datos)"
}

variable "private_subnet_cidr_2" {
  type        = string
  description = "Rango de IPs para la segunda subred privada (Base de Datos, AZ distinta)"
}

variable "az_a" {
  type        = string
  description = "Zona de disponibilidad A"
  default     = "us-east-1a"
}

variable "az_b" {
  type        = string
  description = "Zona de disponibilidad B"
  default     = "us-east-1b"
}