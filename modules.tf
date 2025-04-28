module "network" {
  source = "./modules/network"

  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  app_name         = var.app_name
}

module "security" {
  source = "./modules/security"

  vpc_id   = module.network.vpc_id
  app_name = var.app_name
}

module "compute" {
  source = "./modules/compute"

  ami_id              = var.ami_id
  instance_type       = var.instance_type
  subnet_id           = module.network.public_subnet_id
  security_group_ids  = [module.security.security_group_id]
  app_name           = var.app_name
}

module "api_gateway" {
  source = "./modules/api_gateway"

  app_name          = var.app_name
  instance_dns_name = module.compute.instance_public_dns
}