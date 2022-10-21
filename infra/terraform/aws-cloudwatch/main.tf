module "network" {
  source       = "./modules/network"
  namespace    = var.namespace
  project_name = var.project_name
}

module "instance" {
  source       = "./modules/instance"
  namespace    = var.namespace
  project_name = var.project_name
  ssh_key      = var.ssh_key
  subnet       = module.network.subnet
  vpc          = module.network.vpc
  region       = var.region
}

