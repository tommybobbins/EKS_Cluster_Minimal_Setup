resource "helm_release" "kong" {
  name             = "kong"
  repository       = "https://charts.konghq.com" 
  chart            = "ingress"
  namespace        = "kong"
  create_namespace = true
  timeout          = 600
  values           = [ file("helm/kong-values.yaml") ]
}
