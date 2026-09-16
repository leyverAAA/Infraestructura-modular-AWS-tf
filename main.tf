provider "aws" {
  region = var.region
}

# 1. Módulo de Red
module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_cidr   = var.private_subnet_cidr
  private_subnet_cidr_2 = var.private_subnet_cidr_2
}

# 2. Módulo de Cómputo
module "compute" {
  source           = "./modules/compute"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  instance_type    = var.instance_type
  environment      = var.environment
}

# 3. Módulo de Base de Datos
module "database" {
  source             = "./modules/database"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  web_sg_id          = module.compute.web_sg_id
  db_password        = var.db_password
  environment        = var.environment
}