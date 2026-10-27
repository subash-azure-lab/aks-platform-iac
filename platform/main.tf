data "azurerm_client_config" "current" {}

# Read the results card of the bootstrap layer (hub network, DNS zones).
data "terraform_remote_state" "bootstrap" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstatesubash01"
    container_name       = "aks-platform"
    key                  = "bootstrap-${var.environment}.tfstate"
    use_azuread_auth     = true
  }
}

locals {
  tags = {
    CostCenter  = var.cost_center
    Environment = var.environment
    Project     = "aks-platform"
  }

  boot = data.terraform_remote_state.bootstrap.outputs
  dns  = local.boot.private_dns_zone_ids
}

resource "azurerm_resource_group" "platform" {
  name     = "rg-aksplat-${var.environment}"
  location = var.location
  tags     = local.tags
}

# ---------- Network: the spoke, joined to the hub ----------

module "nsg_aks" {
  source              = "../modules/nsg"
  name                = "nsg-aks-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  tags                = local.tags
}

module "nsg_pe" {
  source              = "../modules/nsg"
  name                = "nsg-pe-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  tags                = local.tags
}

module "spoke" {
  source              = "../modules/vnet"
  name                = "vnet-spoke-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  address_prefix      = var.spoke_address_prefix
  tags                = local.tags

  subnets = [
    { name = "snet-aks", prefix = var.aks_subnet_prefix },
    { name = "snet-pe", prefix = var.pe_subnet_prefix },
  ]

  nsg_ids = {
    "snet-aks" = module.nsg_aks.id
    "snet-pe"  = module.nsg_pe.id
  }
}

module "peering" {
  source           = "../modules/vnet-peering"
  name_a_to_b      = "hub-to-spoke-${var.environment}"
  name_b_to_a      = "spoke-to-hub-${var.environment}"
  vnet_a_name      = local.boot.hub_vnet_name
  vnet_a_id        = local.boot.hub_vnet_id
  resource_group_a = local.boot.resource_group_name
  vnet_b_name      = module.spoke.name
  vnet_b_id        = module.spoke.id
  resource_group_b = azurerm_resource_group.platform.name
}

# ---------- Services ----------

module "log_analytics" {
  source              = "../modules/log-analytics"
  name                = "log-aksplat-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  tags                = local.tags
}

module "acr" {
  source              = "../modules/acr"
  name                = "acraksplat${var.environment}${var.unique_suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  tags                = local.tags
}

module "storage" {
  source              = "../modules/storage-account"
  name                = "stakspl${var.environment}${var.unique_suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  tags                = local.tags
}

module "key_vault" {
  source              = "../modules/key-vault"
  name                = "kv-aksplat-${var.environment}-${var.unique_suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = local.tags
}

# ---------- Private doors (private endpoints) ----------

module "pe_acr" {
  source              = "../modules/private-endpoint"
  name                = "acr-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  subnet_id           = module.spoke.subnet_ids["snet-pe"]
  target_resource_id  = module.acr.id
  subresource_name    = "registry"
  private_dns_zone_id = local.dns["privatelink.azurecr.io"]
  tags                = local.tags
}

module "pe_storage" {
  source              = "../modules/private-endpoint"
  name                = "st-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  subnet_id           = module.spoke.subnet_ids["snet-pe"]
  target_resource_id  = module.storage.id
  subresource_name    = "blob"
  private_dns_zone_id = local.dns["privatelink.blob.core.windows.net"]
  tags                = local.tags
}

module "pe_key_vault" {
  source              = "../modules/private-endpoint"
  name                = "kv-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  subnet_id           = module.spoke.subnet_ids["snet-pe"]
  target_resource_id  = module.key_vault.id
  subresource_name    = "vault"
  private_dns_zone_id = local.dns["privatelink.vaultcore.azure.net"]
  tags                = local.tags
}

# ---------- The factory floor (private AKS) ----------

module "aks" {
  source                     = "../modules/aks"
  name                       = "aks-aksplat-${var.environment}"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.platform.name
  subnet_id                  = module.spoke.subnet_ids["snet-aks"]
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  log_analytics_workspace_id = module.log_analytics.id
  tags                       = local.tags
}

# The cluster's badge may pull images from the registry.
resource "azurerm_role_assignment" "aks_acr_pull" {
  count                = var.assign_acr_pull ? 1 : 0
  scope                = module.acr.id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_object_id
}
