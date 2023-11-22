locals {
  name      = "itcaworkshop"
  version   = "1.28"
  ip_family = "ipv4"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  default_ng_ami_type       = "AL2_x86_64"
  default_ng_instance_types = ["t3.medium", "t3a.medium"]
  default_ng_disk_size      = 50
  default_ng_capacity_type  = "SPOT"

  default_ng_min_size     = 1
  default_ng_max_size     = 3
  default_ng_desired_size = 2

  default_block_device_mappings = {
    xvda = {
      device_name = "/dev/xvda"
      ebs = {
        volume_size           = local.default_ng_disk_size
        volume_type           = "gp3"
        iops                  = 3000
        throughput            = 150
        encrypted             = true
        kms_key_id            = module.ebs_kms_key.key_arn
        delete_on_termination = true
      }
    }
  }

  tags = {
    Project = local.name
  }

  ### Charts
  system_pods_namespace = "kube-system"

  alb_ingress = {
    name       = "aws-load-balancer-controller"
    repository = "https://aws.github.io/eks-charts"
    version    = "1.6.1"
  }

  external_dns = {
    name       = "external-dns"
    repository = "https://kubernetes-sigs.github.io/external-dns"
    version    = "1.13.1"
  }

  external_secrets = {
    name       = "external-secrets"
    repository = "https://charts.external-secrets.io"
    version    = "0.9.9"
  }
}