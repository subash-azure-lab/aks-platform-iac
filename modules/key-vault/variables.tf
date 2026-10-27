variable "name" {
  description = "Key Vault name: 3 to 24 letters, digits and dashes, globally unique"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that holds the vault"
  type        = string
}

variable "tenant_id" {
  description = "Entra tenant ID that owns the vault"
  type        = string
}

variable "purge_protection_enabled" {
  description = "Block permanent deletion for the retention period. Keep true in production."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to the vault"
  type        = map(string)
  default     = {}
}
