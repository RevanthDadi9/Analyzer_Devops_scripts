variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group"
  default     = "analyser_rg"
}

variable "location" {
  type        = string
  description = "Azure Region for all resources"
  default     = "West US"
}

variable "vnet_name" {
  type        = string
  description = "Virtual Network name"
  default     = "analyser_vnet"
}

variable "vnet_address_space" {
  type        = string
  description = "Address space for the Virtual Network"
  default     = "10.0.0.0/16"
}

variable "node_subnet_name" {
  type        = string
  description = "Subnet for Node API VM"
  default     = "node_subnet"
}

variable "node_subnet_address" {
  type        = string
  description = "CIDR block for Node API subnet"
  default     = "10.0.1.0/24"
}

variable "flask_subnet_name" {
  type        = string
  description = "Subnet for Flask API VM"
  default     = "flask_subnet"
}

variable "flask_subnet_address" {
  type        = string
  description = "CIDR block for Flask API subnet"
  default     = "10.0.2.0/24"
}

variable "admin_username" {
  type        = string
  description = "Admin username for both VMs"
  default     = "azureuser"
}

variable "admin_password" {
  type        = string
  description = "Admin password for both VMs"
  sensitive   = true
  default     = "revanth.99"
}
