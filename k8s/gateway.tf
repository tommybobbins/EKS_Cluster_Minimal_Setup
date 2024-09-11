resource "helm_release" "kong-gateway" {
  name      = "kong-gateway"
  chart     = "./gateway/kong/helm"
  namespace = "default"
  timeout   = 600
}