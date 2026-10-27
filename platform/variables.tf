variable "subscription_id" {
  description = "Azure subscription to deploy into"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment name: dev or prod"
  type        = string
}

variable "cost_center" {
  description = "Value for the CostCenter tag"
  type        = string
  default     = "AI-Platform"
}

variable "unique_suffix" {
  description = "Short lowercase text that makes globally unique names (registry, storage, vault) unique to you"
  type        = string
}

variable "spoke_address_prefix" {
  description = "Address space of the spoke VNet"
  type        = string
}

variable "aks_subnet_prefix" {
  description = "Address range of the subnet that holds the cluster nodes"
  type        = string
}

variable "pe_subnet_prefix" {
  description = "Address range of the subnet that holds the private endpoints"
  type        = string
}

variable "assign_acr_pull" {
  description = "Let the cluster pull images from the registry. Needs a pipeline identity that may create role assignments."
  type        = bool
  default     = false
}
