variable "zone_names" {
  description = "Private DNS zone names to create, for example privatelink.azurecr.io"
  type        = list(string)
}

variable "resource_group_name" {
  description = "Resource group that holds the zones"
  type        = string
}

variable "vnet_id" {
  description = "ID of the VNet the zones are linked to"
  type        = string
}

variable "tags" {
  description = "Tags applied to the zones"
  type        = map(string)
  default     = {}
}