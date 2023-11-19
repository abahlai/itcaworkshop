locals {
  cluster_name    = "workshop"
  cluster_version = "1.28."

  worker_name  = "default"
  worker_size  = "s-2vcpu-4gb"
  worker_count = 2

  maintenance_window = {
    start_time = "04:00"
    day        = "sunday"
  }
}