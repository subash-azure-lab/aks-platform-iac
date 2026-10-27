variable "name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that holds the cluster"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet the nodes are placed in"
  type        = string
}

variable "tenant_id" {
  description = "Entra tenant ID whose users and groups may log in to the cluster"
  type        = string
}

variable "vm_size" {
  description = "Size of the nodes"
  type        = string
  default     = "Standard_D2as_v7"
}

variable "node_count" {
  description = "Number of nodes in the system pool"
  type        = number
  default     = 1
}

variable "kubernetes_version" {
  description = "Kubernetes version. Null lets Azure pick the current default."
  type        = string
  default     = null
}

variable "log_analytics_workspace_id" {
  description = "Workspace that receives container logs. Null turns monitoring off."
  type        = string
  default     = null
}

variable "service_cidr" {
  description = "Address range for Kubernetes services. Must not overlap any VNet."
  type        = string
  default     = "172.16.0.0/16"
}

variable "dns_service_ip" {
  description = "IP of the cluster DNS service. Must be inside service_cidr."
  type        = string
  default     = "172.16.0.10"
}

variable "tags" {
  description = "Tags applied to the cluster"
  type        = map(string)
  default     = {}
}
