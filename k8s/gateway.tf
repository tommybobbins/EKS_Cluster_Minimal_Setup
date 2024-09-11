resource "helm_release" "kong-gateway" {
  name    = "kong-gateway"
  chart   = "./gateway/kong-gateway"
  timeout = 600
}