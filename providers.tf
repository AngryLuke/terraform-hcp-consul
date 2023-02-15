terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.51.0"
    }

    hcp = {
      source  = "hashicorp/hcp"
      version = "0.53.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }

  }
}

provider "consul" {
  address    = hcp_consul_cluster.main[0].consul_public_endpoint_url
  datacenter = hcp_consul_cluster.main[0].datacenter
  token      = hcp_consul_cluster_root_token.token.secret_id
}