variable "name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that holds the workspace"
  type        = string
}

variable "retention_in_days" {
  description = "How many days logs are kept"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags applied to the workspace"
  type        = map(string)
  default     = {}
}
