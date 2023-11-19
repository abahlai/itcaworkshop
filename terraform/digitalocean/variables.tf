variable "region" {
  type        = string
  default     = "fra1"
  description = "(Required) The slug identifier for the region where the Kubernetes cluster will be created."
}

variable "registry_tier" {
  type        = string
  default     = "starter"
  description = "(Required) The slug identifier for the subscription tier to use (starter, basic, or professional)"
}