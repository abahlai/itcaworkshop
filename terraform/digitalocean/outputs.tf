output "cluster_id" {
  value = digitalocean_kubernetes_cluster.workshop.id
}

output "cluster_name" {
  value = digitalocean_kubernetes_cluster.workshop.name
}

output "cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.workshop.endpoint
}