output "resource_group_name" {
  description = "Resource group of the platform layer"
  value       = azurerm_resource_group.platform.name
}

output "aks_name" {
  description = "Name of the AKS cluster"
  value       = module.aks.name
}

output "aks_oidc_issuer_url" {
  description = "Cluster OIDC issuer, used for workload identity trust"
  value       = module.aks.oidc_issuer_url
}

output "acr_login_server" {
  description = "Address of the container registry"
  value       = module.acr.login_server
}

output "key_vault_uri" {
  description = "Address of the Key Vault"
  value       = module.key_vault.vault_uri
}
