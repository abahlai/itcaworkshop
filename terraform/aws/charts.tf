################################################################################
# Helm Charts
################################################################################

### AWS ALB Ingress Controller
resource "helm_release" "alb_ingress_controller" {
  chart      = local.alb_ingress.name
  name       = local.alb_ingress.name
  repository = local.alb_ingress.repository
  namespace  = local.system_pods_namespace
  version    = local.alb_ingress.version

  set {
    name  = "clusterName"
    value = module.eks.cluster_name
  }

  set {
    name  = "region"
    value = data.aws_region.current.name
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account_v1.alb_ingress.metadata[0].name
  }

  set {
    name  = "defaultTargetType"
    value = "ip"
  }
}

### External DNS
resource "helm_release" "external_dns" {
  chart      = local.external_dns.name
  name       = local.external_dns.name
  repository = local.external_dns.repository
  namespace  = local.system_pods_namespace
  version    = local.external_dns.version

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = kubernetes_service_account_v1.external_dns.metadata[0].name
  }

  set {
    name  = "provider"
    value = "aws"
  }

  set {
    name  = "env[0].name"
    value = "AWS_DEFAULT_REGION"
  }

  set {
    name  = "env[0].value"
    value = data.aws_region.current.name
  }
}