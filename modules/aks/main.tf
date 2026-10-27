resource "azurerm_kubernetes_cluster" "this" {
  #checkov:skip=CKV_AZURE_117:Disk encryption set needs a Key Vault key and DES; platform-managed encryption at rest is enough for the lab. Add for regulated prod.
  #checkov:skip=CKV_AZURE_170:Free tier on purpose to keep lab cost low. Use the Standard tier (SLA) in prod.
  #checkov:skip=CKV_AZURE_226:Ephemeral OS disks depend on VM size cache; revisit with the final node size.
  #checkov:skip=CKV_AZURE_227:Host encryption needs a subscription feature registration; planned for prod.
  #checkov:skip=CKV_AZURE_232:Single-node lab cluster must run apps on the system pool. Prod gets a separate user pool and this turns on.
  name                              = var.name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  dns_prefix                        = var.name
  kubernetes_version                = var.kubernetes_version
  sku_tier                          = "Free"
  private_cluster_enabled           = true
  oidc_issuer_enabled               = true
  workload_identity_enabled         = true
  azure_policy_enabled              = true
  role_based_access_control_enabled = true
  local_account_disabled            = true
  automatic_upgrade_channel         = "patch"
  tags                              = var.tags

  default_node_pool {
    name           = "system"
    vm_size        = var.vm_size
    node_count     = var.node_count
    vnet_subnet_id = var.subnet_id
    max_pods       = 110
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_data_plane  = "cilium"
    network_policy      = "cilium"
    load_balancer_sku   = "standard"
    service_cidr        = var.service_cidr
    dns_service_ip      = var.dns_service_ip
  }

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = true
    tenant_id          = var.tenant_id
  }

  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id == null ? [] : [1]
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }
}
