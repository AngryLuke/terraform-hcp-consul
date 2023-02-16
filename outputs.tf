output "consul_root_token" {
  value     = hcp_consul_cluster_root_token.token.secret_id
  sensitive = true
}

output "consul_public_url" {
  value = data.hcp_consul_cluster.main.consul_public_endpoint_url
}

output "consul_private_url" {
  value = data.hcp_consul_cluster.main.consul_private_endpoint_url
}

output "consul_config" {
  value = base64decode(data.hcp_consul_cluster.main.consul_config_file)
}

output "consul_ca" {
  value = base64decode(data.hcp_consul_cluster.main.consul_ca_file)
}

output "client_yaml" {
  value = data.hcp_consul_agent_helm_config.consul_helm.config
}

output "manifest_k8s" {
  value     = data.hcp_consul_agent_kubernetes_secret.consul_secrets.secret
  sensitive = true
}

output "manifest_hcl" {
  value = yamldecode(data.hcp_consul_agent_kubernetes_secret.consul_secrets.secret)
  sensitive = true
}

output "manifest_bootstrap" {
  value = yamldecode(hcp_consul_cluster_root_token.token.kubernetes_secret)
  sensitive = true
}