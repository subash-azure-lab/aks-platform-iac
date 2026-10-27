output "resource_group_name" {
  description = "Resource group of the bootstrap layer"
  value       = azurerm_resource_group.bootstrap.name
}

output "hub_vnet_id" {
  description = "Resource ID of the hub VNet"
  value       = module.hub.id
}

output "hub_vnet_name" {
  description = "Name of the hub VNet"
  value       = module.hub.name
}

output "private_dns_zone_ids" {
  description = "Map of private DNS zone name to zone ID"
  value       = module.private_dns.zone_ids
}
