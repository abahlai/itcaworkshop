# Get the latest kubernetes patch version
data "digitalocean_kubernetes_versions" "patch" {
  version_prefix = local.cluster_version
}

# Create a new container registry
resource "digitalocean_container_registry" "workshop_registry" {
  name                   = local.cluster_name
  subscription_tier_slug = var.registry_tier
  region                 = var.region
}

# Create a new kubernetes cluster with default node pool
resource "digitalocean_kubernetes_cluster" "workshop" {
  depends_on = [digitalocean_container_registry.workshop_registry]

  name                 = local.cluster_name
  region               = var.region
  auto_upgrade         = true
  registry_integration = true
  version              = data.digitalocean_kubernetes_versions.patch.latest_version

  node_pool {
    name       = local.worker_name
    size       = local.worker_size
    node_count = local.worker_count

    labels = {
      region = var.region
      worker = local.worker_name
    }

    tags = [var.region]
  }

  dynamic "maintenance_policy" {
    for_each = length(keys(local.maintenance_window)) == 0 ? [] : [local.maintenance_window]

    content {
      start_time = maintenance_policy.value.start_time
      day        = maintenance_policy.value.day
    }
  }
}