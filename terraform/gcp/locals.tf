locals {
  name     = "itcaworkshop"
  vpc_name = "vpc-01"

  default_node_pool_name          = "default-node-pool"
  default_machine_type            = "e2-medium"
  default_node_locations          = "${var.region}-b,${var.region}-c"
  default_node_pool_min_size      = 1
  default_node_pool_max_size      = 3
  default_node_pool_desired_count = 2
  default_node_pool_disk_size     = 64
  default_node_pool_disk_type     = "pd-standard"
  default_node_pool_sa            = "gitlab-ci@${var.project_id}.iam.gserviceaccount.com"

}