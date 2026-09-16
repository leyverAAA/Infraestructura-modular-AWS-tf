variable "vpc_id" {
  type        = string
  description = "ID de la VPC donde se asociará el Security Group"
}

variable "public_subnet_id" {
  type        = string
  description = "ID de la subred pública donde se desplegará el servidor"
}

variable "instance_type" {
  type        = string
  description = "Tipo de instancia de EC2 (ej. t2.micro)"
  default     = "t2.micro"
}

variable "environment" {
  type        = string
  description = "Nombre del entorno (ej. dev, prod)"
  default     = "dev"
}