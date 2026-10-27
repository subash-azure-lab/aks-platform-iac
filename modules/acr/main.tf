resource "azurerm_container_registry" "this" {
  #checkov:skip=CKV_AZURE_164:Content trust (signed images) needs a signing process we do not have yet.
  #checkov:skip=CKV_AZURE_165:Geo-replication costs extra per region; single-region lab.
  #checkov:skip=CKV_AZURE_166:Image quarantine is a preview feature.
  #checkov:skip=CKV_AZURE_233:Zone redundancy is a prod setting; lab keeps cost low.
  #checkov:skip=CKV_AZURE_237:Dedicated data endpoints need extra private DNS records; revisit in prod.
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  admin_enabled                 = false
  retention_policy_in_days      = 7
  public_network_access_enabled = false
  tags                          = var.tags
}
