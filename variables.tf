variable "min_consul_version" {
  description = "Consul version to use"
  default     = "v1.14.0"
}

variable "hcp_tier" {
  description = "HCP Tier to use for Consul cluster: https://cloud.hashicorp.com/products/consul/pricing"
  default     = "development"
}

variable "hcp_tier_size" {
  description = "HCP Tier size to use for Consul cluster: https://cloud.hashicorp.com/products/consul/pricing"
  default     = "extra-small"
}

variable "enable_public_endpoint" {
  description = "Enable or not public endpoint for HCP Consul"
  default     = "false"
}

variable "consul_namespace" {
  description = "Namespace where Consul clients and their secrets will be deployed"
  default     = "consul"
}

variable "hcp_consul_cluster" {
  description = "Name of HCP cluster you want to use"
  default     = ""
  # We do a validation of the variable to contain only numbers, letters or hyphens. This is done with regex by putting non valid values in a list
  # and checking that the list is empty (false if > 0)
  validation {
    condition     = length(var.hcp_consul_cluster) < 37 && length(var.hcp_consul_cluster) > 2 && length(regexall("([^A-Za-z0-9-]+)", var.hcp_consul_cluster)) == 0
    error_message = "The cluster name must be between 3 and 36 characters in length and contains only letters, numbers or hyphens"
  }
}

variable "eks_cluster_name" {
  description = "Name of EKS cluster you want to use (already created)"
  default     = ""
}

variable "eks_cluster_endpoint" {
  description = "EKS kubernetes FQDN API"
  default     = ""
}

variable "hvn_id" {
  description = "Name of HCP HVN you want to use"
  default     = ""
  validation {
    condition     = length(var.hvn_id) < 37 && length(var.hvn_id) > 2 && length(regexall("([^A-Za-z0-9-]+)", var.hvn_id)) == 0
    error_message = "The HVN name must be between 3 and 36 characters in length and contains only letters, numbers or hyphens"
  }
}