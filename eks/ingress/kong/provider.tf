provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-kind"
}

terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}


provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }

#  # localhost registry with password protection
#  registry {
#    url  = "https://charts.konghq.com"
#  }
}
