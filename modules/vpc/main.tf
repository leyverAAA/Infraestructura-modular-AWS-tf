# 1. La VPC (Nuestra red privada virtual en AWS)
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-produccion"
  }
}

# 2. Subred Pública (Conectada a Internet)
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true # Asigna IP pública automáticamente a las EC2 aquí
  tags = {
    Name = "subnet-publica"
  }
}

# 3. Subred Privada 1 (Zona A) - Aislada del mundo exterior
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.az_a
  tags = {
    Name = "subnet-privada-1"
  }
}

# 4. Subred Privada 2 (Zona B) - Requisito de RDS (AZs distintas)
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_2
  availability_zone = var.az_b
  tags = {
    Name = "subnet-privada-2"
  }
}

# 5. Puerta de enlace a Internet (Internet Gateway)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "igw-proyecto"
  }
}

# 6. Tabla de ruteo para dirigir el tráfico público hacia el Internet Gateway
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" # Todo el tráfico exterior
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "tabla-ruta-publica"
  }
}

# 7. Asociar la tabla de ruteo con la subred pública
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}