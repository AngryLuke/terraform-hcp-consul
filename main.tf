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

# Fetch data for EKS cluster
# 
data "aws_eks_cluster_auth" "cluster" {
  # Name of the cluster
  name = var.eks_cluster_name
}

data "hcp_consul_agent_helm_config" "consul_helm" {
  # ID of the HCP Consul cluster
  cluster_id = var.hcp_consul_cluster
  # kubernetes FQDN API
  kubernetes_endpoint = var.eks_cluster_endpoint

  depends_on = [
    hcp_consul_cluster.main
  ]
}

data "hcp_consul_agent_kubernetes_secret" "consul_secrets" {
  # ID of the HCP Consul cluster
  cluster_id = var.hcp_consul_cluster

  depends_on = [
    hcp_consul_cluster.main,
    data.aws_eks_cluster_auth.cluster
  ]
}
#
# End fetching data for EKS cluster

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