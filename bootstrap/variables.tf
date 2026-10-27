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

variable "hub_address_prefix" {
  description = "Address space of the hub VNet"
  type        = string
}

variable "runner_subnet_prefix" {
  description = "Address range of the subnet that holds the runner VM"
  type        = string
}

variable "private_dns_zones" {
  description = "Private DNS zones created and linked to the hub VNet"
  type        = list(string)
  default = [
    "privatelink.azurecr.io",
    "privatelink.blob.core.windows.net",
    "privatelink.vaultcore.azure.net",
  ]
}

variable "enable_runner" {
  description = "Switch for the runner VM and its public IP. Costs money while true."
  type        = bool
  default     = false
}

variable "runner_ssh_public_key" {
  description = "Public SSH key for the runner VM. Only needed when enable_runner is true."
  type        = string
  default     = ""
}