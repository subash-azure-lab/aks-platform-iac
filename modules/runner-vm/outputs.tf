output "vm_id" {
  description = "Resource ID of the VM"
  value       = azurerm_linux_virtual_machine.this.id
}

output "private_ip" {
  description = "Private IP address of the VM"
  value       = azurerm_network_interface.this.private_ip_address
}

output "public_ip" {
  description = "Public IP address for outbound access, or null if disabled"
  value       = one(azurerm_public_ip.this[*].ip_address)
}

output "identity_principal_id" {
  description = "Principal ID of the VM's managed identity, used for role assignments"
  value       = azurerm_user_assigned_identity.this.principal_id
}

output "identity_client_id" {
  description = "Client ID of the VM's managed identity"
  value       = azurerm_user_assigned_identity.this.client_id
}
