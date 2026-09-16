# 1. Obtener la última versión de la AMI oficial de Amazon Linux 2023
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# 2. Cortafuegos (Security Group) para el Servidor Web
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg-${var.environment}"
  description = "Permitir trafico HTTP de entrada"
  vpc_id      = var.vpc_id

  # Permitir tráfico web HTTP (Puerto 80) desde cualquier parte
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permitir todo el tráfico de salida (Egress)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-web-${var.environment}"
  }
}

# 3. Instancia de Servidor Web (EC2)
resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  # Script de arranque: instala Apache y crea una página de prueba
  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Servidor Web desplegado exitosamente con Terraform (${var.environment})</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "servidor-web-${var.environment}"
  }
}