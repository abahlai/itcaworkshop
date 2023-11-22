################################################################################
# Helm Charts
################################################################################

### External DNS
resource "helm_release" "external_dns" {
  chart      = "external-dns"
  name       = "external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns"
  namespace  = "kube-system"
  version    = "1.13.1"

  set {
    name  = "provider"
    value = "digitalocean"
  }

  set {
    name  = "env[0].name"
    value = "DO_TOKEN"
  }

  set {
    name  = "env[0].value"
    value = var.do_token
  }
}