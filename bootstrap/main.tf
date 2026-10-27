locals {
  tags = {
    CostCenter  = var.cost_center
    Environment = var.environment
    Project     = "aks-platform"
  }
}

resource "azurerm_resource_group" "bootstrap" {
  name     = "rg-aksplat-boot-${var.environment}"
  location = var.location
  tags     = local.tags
}

module "nsg_runner" {
  source              = "../modules/nsg"
  name                = "nsg-runner-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.bootstrap.name
  tags                = local.tags
}

module "hub" {
  source              = "../modules/vnet"
  name                = "vnet-hub-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.bootstrap.name
  address_prefix      = var.hub_address_prefix
  tags                = local.tags

  subnets = [
    { name = "snet-runner", prefix = var.runner_subnet_prefix },
  ]

  nsg_ids = {
    "snet-runner" = module.nsg_runner.id
  }
}

module "private_dns" {
  source              = "../modules/private-dns"
  zone_names          = var.private_dns_zones
  resource_group_name = azurerm_resource_group.bootstrap.name
  vnet_id             = module.hub.id
  tags                = local.tags
}

# The runner VM is switched off by default (enable_runner = false) because it costs money.
module "runner" {
  count = var.enable_runner ? 1 : 0

  source               = "../modules/runner-vm"
  name                 = "vm-runner-${var.environment}"
  location             = var.location
  resource_group_name  = azurerm_resource_group.bootstrap.name
  subnet_id            = module.hub.subnet_ids["snet-runner"]
  admin_ssh_public_key = var.runner_ssh_public_key
  enable_public_ip     = true
  tags                 = local.tags
}