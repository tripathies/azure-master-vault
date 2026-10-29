variable "subscription_id" {
  description = "Target Azure subscription ID; provide via environment or an untracked local tfvars file."
  type        = string
  sensitive   = true
}

variable "resource_group_name" {
  description = "Unique name for the example resource group."
  type        = string
}

variable "location" {
  description = "Azure region for the resource group."
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Governance tags for the example resource group."
  type        = map(string)
  default = {
    managed-by = "terraform"
    environment = "sandbox"
  }
}
