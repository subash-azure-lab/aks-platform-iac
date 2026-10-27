variable "name" {
  description = "Short name used to build the endpoint name, for example acr or storage"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that holds the private endpoint"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet that receives the private IP address"
  type        = string
}

variable "target_resource_id" {
  description = "ID of the Azure service the endpoint connects to"
  type        = string
}

variable "subresource_name" {
  description = "Which part of the service to connect to, for example registry, blob or vault"
  type        = string
}

variable "private_dns_zone_id" {
  description = "ID of the private DNS zone that receives the endpoint's address"
  type        = string
}

variable "tags" {
  description = "Tags applied to the private endpoint"
  type        = map(string)
  default     = {}
}
