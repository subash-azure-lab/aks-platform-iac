output "id" {
  description = "Resource ID of the storage account"
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "Blob service address"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}
