# Define variables

variable "location" {
  description = "The Azure region to deploy resources."
  type        = string
  default     = "East US" # You can change this to the desired Azure region
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
  default     = "reactstorageacct"
}
