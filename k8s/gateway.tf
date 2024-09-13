resource "helm_release" "kong-gateway" {
  count   = var.gateway_flavour == "kong" ? 1 : 0
  name    = "kong-gateway"
  create_namespace = true
  chart   = "./gateway/kong-gateway"
  timeout = 600
}

resource "helm_release" "nginx-gateway" {
  count   = var.gateway_flavour == "nginx" ? 1 : 0
  name    = "nginx-gateway"
  chart   = "./gateway/nginx-gateway"
  create_namespace = true
  timeout = 600
}

resource "helm_release" "kong-public" {
  count            = var.gateway_flavour == "kong" ? 1 : 0
  name             = "kong-public"
  repository       = "https://charts.konghq.com"
  chart            = "kong"
  create_namespace = true
  namespace        = "kong-public"
  version          = var.kong_helm_version
  timeout          = 600
  values = [
    "${templatefile("./gateway/kong-ingress/kong-public-values.yaml", {
      cert_arn          = data.aws_acm_certificate.ssl_cert.arn
      kong_min_replicas = lookup(var.kong_replicas, "min")
      kong_max_replicas = lookup(var.kong_replicas, "max")
      public_subnets    = join(",", sort(data.aws_subnets.public_subnets.ids))
    })}"
  ]
  depends_on = [
    aws_iam_role_policy_attachment.aws_load_balancer_controller
  ]
}

resource "helm_release" "kong_echo_service_gateway_api" {
  count   = (var.gateway_flavour == "kong" && var.gateway_api == true) ? 1 : 0
  name    = "kong-echo-service-gateway-api"
  chart   = "./gateway/kong-echo-service-gateway-api"
  namespace = "echo-service"
  create_namespace = true
  timeout = 600
  depends_on = [helm_release.kong-public]
}

resource "helm_release" "kong_echo_service_ingress" {
  count   = (var.gateway_flavour == "kong" && var.gateway_api == false) ? 1 : 0
  name    = "kong-echo-service-ingress"
  chart   = "./gateway/kong-echo-service-ingress"
  namespace = "echo-service"
  create_namespace = true
  timeout = 600
  depends_on = [helm_release.kong-public]
}