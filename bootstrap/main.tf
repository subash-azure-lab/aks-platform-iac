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