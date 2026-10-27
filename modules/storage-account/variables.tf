variable "name" {
  description = "Storage account name: 3 to 24 lowercase letters and digits, globally unique"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that holds the storage account"
  type        = string
}

variable "replication_type" {
  description = "Redundancy: LRS, ZRS or GRS"
  type        = string
  default     = "LRS"
}

variable "tags" {
  description = "Tags applied to the storage account"
  type        = map(string)
  default     = {}
}
