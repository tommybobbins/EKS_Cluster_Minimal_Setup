# kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml

data "kubectl_path_documents" "manifests" {
  pattern = "./gateway/${var.gateway_flavour}/manifests/*.yaml"
}

resource "kubectl_manifest" "gateway" {
  for_each  = toset(data.kubectl_path_documents.manifests.documents)
  yaml_body = each.value
}
