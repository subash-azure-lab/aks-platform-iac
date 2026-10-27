resource "azurerm_virtual_network_peering" "a_to_b" {
  name                         = var.name_a_to_b
  resource_group_name          = var.resource_group_a
  virtual_network_name         = var.vnet_a_name
  remote_virtual_network_id    = var.vnet_b_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "b_to_a" {
  name                         = var.name_b_to_a
  resource_group_name          = var.resource_group_b
  virtual_network_name         = var.vnet_b_name
  remote_virtual_network_id    = var.vnet_a_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
