output "zone_ids" {
  description = "Map of zone name to zone ID"
  value       = { for k, z in azurerm_private_dns_zone.this : k => z.id }
}