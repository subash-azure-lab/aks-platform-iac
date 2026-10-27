variable "name_a_to_b" {
  description = "Name of the peering that starts at network A"
  type        = string
}

variable "name_b_to_a" {
  description = "Name of the peering that starts at network B"
  type        = string
}

variable "vnet_a_name" {
  description = "Name of network A"
  type        = string
}

variable "vnet_a_id" {
  description = "Resource ID of network A"
  type        = string
}

variable "resource_group_a" {
  description = "Resource group of network A"
  type        = string
}

variable "vnet_b_name" {
  description = "Name of network B"
  type        = string
}

variable "vnet_b_id" {
  description = "Resource ID of network B"
  type        = string
}

variable "resource_group_b" {
  description = "Resource group of network B"
  type        = string
}
