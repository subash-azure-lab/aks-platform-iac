variable "name" {
  description = "Name of the runner VM"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the VM and its network card"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet the VM is placed in"
  type        = string
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_D2as_v7"
}

variable "admin_username" {
  description = "Admin user name on the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  description = "Public SSH key allowed to sign in"
  type        = string
}

variable "enable_public_ip" {
  description = "Give the VM a public IP for outbound access (inbound stays blocked by the NSG)"
  type        = bool
  default     = true
}

variable "custom_data" {
  description = "Cloud-init script run on first boot, as plain text"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags applied to the resources"
  type        = map(string)
  default     = {}
}
