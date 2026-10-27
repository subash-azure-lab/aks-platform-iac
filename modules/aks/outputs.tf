output "id" {
  description = "Resource ID of the cluster"
  value       = azurerm_kubernetes_cluster.this.id
}

output "name" {
  description = "Name of the cluster"
  value       = azurerm_kubernetes_cluster.this.name
}

output "oidc_issuer_url" {
  description = "Cluster OIDC issuer address, used for workload identity trust"
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
}

output "kubelet_object_id" {
  description = "Object ID of the kubelet identity, which pulls images from the registry"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}

output "node_resource_group" {
  description = "Resource group AKS creates for the nodes"
  value       = azurerm_kubernetes_cluster.this.node_resource_group
}
