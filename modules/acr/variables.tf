variable "name" {
  description = "Registry name: 5 to 50 lowercase letters and digits, globally unique"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that holds the registry"
  type        = string
}

variable "sku" {
  description = "Registry tier. Premium is required for private endpoints."
  type        = string
  default     = "Premium"
}

variable "tags" {
  description = "Tags applied to the registry"
  type        = map(string)
  default     = {}
}
