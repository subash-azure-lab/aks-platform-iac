output "a_to_b_id" {
  description = "ID of the peering from A to B"
  value       = azurerm_virtual_network_peering.a_to_b.id
}

output "b_to_a_id" {
  description = "ID of the peering from B to A"
  value       = azurerm_virtual_network_peering.b_to_a.id
}
