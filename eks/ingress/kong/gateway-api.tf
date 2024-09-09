data "kubectl_path_documents" "manifests" {
  pattern = "./manifests/*.yaml"
}

resource "kubectl_manifest" "kong_gateway" {
  for_each  = toset(data.kubectl_path_documents.manifests.documents)
  yaml_body = each.value
}
