resource "random_id" "server" {
  byte_length = 2
}

# Fetch the hvn_id so that we don't create a new one
data "hcp_hvn" "main" {
  hvn_id = var.hvn_id
}

resource "hcp_consul_cluster" "main" {
  count              = var.hcp_consul_cluster != "" ? 1 : 0
  hvn_id             = data.hcp_hvn.main.hvn_id
  cluster_id         = var.hcp_consul_cluster
  tier               = var.hcp_tier
  public_endpoint    = var.enable_public_endpoint
  min_consul_version = var.min_consul_version
  size               = var.hcp_tier_size
}

data "hcp_consul_cluster" "main" {
  cluster_id = var.hcp_consul_cluster

  depends_on = [
    hcp_consul_cluster.main
  ]
}

resource "hcp_consul_cluster_root_token" "token" {
  cluster_id = data.hcp_consul_cluster.main.id
}

# Create Admin Partition and Namespace for eks 
resource "consul_admin_partition" "eks-dev" {
  name        = "eks-dev"
  description = "Partition for eks service"
}

# Create Admin Partition and Namespace for fargate
resource "consul_admin_partition" "fargate-dev" {
  name        = "fargate-dev"
  description = "Partition for fargate service"
}