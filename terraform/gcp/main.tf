data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_id
  name                       = local.name
  region                     = var.region
  zones                      = ["${var.region}-a", "${var.region}-b", "${var.region}-c"]
  network                    = local.vpc_name
  subnetwork                 = "${var.region}-01"
  ip_range_pods              = "${var.region}-01-gke-01-pods"
  ip_range_services          = "${var.region}-01-gke-01-services"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false

  node_pools = [
    {
      name               = local.default_node_pool_name
      machine_type       = local.default_machine_type
      node_locations     = local.default_node_locations
      min_count          = local.default_node_pool_min_size
      max_count          = local.default_node_pool_max_size
      initial_node_count = local.default_node_pool_desired_count
      disk_size_gb       = local.default_node_pool_disk_size
      disk_type          = local.default_node_pool_disk_type
      image_type         = "COS_CONTAINERD"
      enable_gcfs        = false
      enable_gvnic       = false
      logging_variant    = "DEFAULT"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = local.default_node_pool_sa
      spot               = false
      preemptible        = false
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "${local.name}-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}