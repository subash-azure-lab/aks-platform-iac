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