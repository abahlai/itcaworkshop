################################################################################
# K8S Resources
################################################################################

# ALB Ingress Controller
resource "kubernetes_service_account_v1" "alb_ingress" {
  metadata {
    annotations = {
      "eks.amazonaws.com/role-arn" = "${module.alb_ingress_role.iam_role_arn}"
    }
    name      = local.alb_ingress.name
    namespace = local.system_pods_namespace
  }
}

resource "kubernetes_secret_v1" "alb_ingress" {
  metadata {
    annotations = {
      "kubernetes.io/service-account.name"      = local.alb_ingress.name
      "kubernetes.io/service-account.namespace" = local.system_pods_namespace
    }
    namespace     = local.system_pods_namespace
    generate_name = "${local.alb_ingress.name}-token-"
  }

  type = "kubernetes.io/service-account-token"

  depends_on = [
    kubernetes_service_account_v1.alb_ingress
  ]
}

# External DNS
resource "kubernetes_service_account_v1" "external_dns" {
  metadata {
    annotations = {
      "eks.amazonaws.com/role-arn" = "${module.external_dns_role.iam_role_arn}"
    }
    name      = local.external_dns.name
    namespace = local.system_pods_namespace
  }
}

resource "kubernetes_secret_v1" "external_dns" {
  metadata {
    annotations = {
      "kubernetes.io/service-account.name"      = local.external_dns.name
      "kubernetes.io/service-account.namespace" = local.system_pods_namespace
    }
    namespace     = local.system_pods_namespace
    generate_name = "${local.external_dns.name}-token-"
  }

  type = "kubernetes.io/service-account-token"

  depends_on = [
    kubernetes_service_account_v1.external_dns
  ]
}

# External Secrets Operator
resource "kubernetes_service_account_v1" "external_secrets" {
  metadata {
    annotations = {
      "eks.amazonaws.com/role-arn" = "${module.external_secrets_role.iam_role_arn}"
    }
    name      = local.external_secrets.name
    namespace = local.system_pods_namespace
  }
}

resource "kubernetes_secret_v1" "external_secrets" {
  metadata {
    annotations = {
      "kubernetes.io/service-account.name"      = local.external_secrets.name
      "kubernetes.io/service-account.namespace" = local.system_pods_namespace
    }
    namespace     = local.system_pods_namespace
    generate_name = "${local.external_secrets.name}-token-"
  }

  type = "kubernetes.io/service-account-token"

  depends_on = [
    kubernetes_service_account_v1.external_secrets
  ]
}