resource "azurerm_storage_account" "this" {
  #checkov:skip=CKV_AZURE_206:Replication is a variable (LRS in the lab, GRS or ZRS in prod).
  #checkov:skip=CKV_AZURE_33:The Queue service is not used; only Blob is.
  #checkov:skip=CKV2_AZURE_33:False positive. The private endpoint exists in the platform layer (module pe_storage); Checkov cannot follow module inputs.
  #checkov:skip=CKV2_AZURE_1:Customer-managed keys need a Key Vault key and identity; platform-managed keys are enough for the lab.
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  account_tier                    = "Standard"
  account_kind                    = "StorageV2"
  account_replication_type        = var.replication_type
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false
  shared_access_key_enabled       = false
  default_to_oauth_authentication = true
  tags                            = var.tags

  blob_properties {
    versioning_enabled  = true
    change_feed_enabled = true

    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 7
    }
  }
}
