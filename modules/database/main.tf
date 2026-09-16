# 1. Grupo de Subredes para RDS (Requisito de AWS)
resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group-${var.environment}"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "db-subnet-group-${var.environment}"
  }
}

# 2. Cortafuegos (Security Group) para la Base de Datos
resource "aws_security_group" "db_sg" {
  name        = "db-sg-${var.environment}"
  description = "Permitir trafico MySQL unicamente desde el servidor web"
  vpc_id      = var.vpc_id

  # CONEXIÓN SEGURA: Solo permite el puerto 3306 desde el Security Group Web
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.web_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-db-${var.environment}"
  }
}

# 3. Instancia de Base de Datos RDS (MySQL)
resource "aws_db_instance" "main" {
  allocated_storage      = 20
  db_name                = var.db_name
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true # Facilita borrar el entorno sin respaldos pesados

  tags = {
    Name = "rds-mysql-${var.environment}"
  }
}