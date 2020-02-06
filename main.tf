provider "aws" {
  region = var.aws_region
}

module "networking" {
  source = "./networking"
  vpc_cidr = var.vpc_cidr
  subnets_cidrs = var.subnets_cidr
  access_ips = var.access_ips
  project_name = var.project_name
}

module "ec2" {
  source = "./ec2"
  public_key_name = var.public_key_name
  instance_count = var.instance_count
  instance_type = var.instance_type
  project_name = var.project_name
  message = var.message
  subnets = module.networking.vpc_subnets
  security_group = module.networking.security_group
}


resource "null_resource" "sleep" {
  depends_on = [module.ec2.server_ip]
  provisioner "local-exec" {
    command = "sleep 30s"
  }
}

