resource "azurerm_key_vault" "this" {
  #checkov:skip=CKV_AZURE_110:Purge protection blocks destroy-and-rebuild with the same name. It is a variable; prod sets it to true.
  #checkov:skip=CKV2_AZURE_32:False positive. The private endpoint exists in the platform layer (module pe_key_vault); Checkov cannot follow module inputs.
  #checkov:skip=CKV_AZURE_42:Same reason as CKV_AZURE_110. Soft delete (7 days) is already on.
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = "standard"
  rbac_authorization_enabled    = true
  purge_protection_enabled      = var.purge_protection_enabled
  soft_delete_retention_days    = 7
  public_network_access_enabled = false
  tags                          = var.tags

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }
}
