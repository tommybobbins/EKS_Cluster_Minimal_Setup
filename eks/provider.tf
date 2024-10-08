locals {
  name = "eks-mvp"
}


provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment = "development"
      Owner       = "tommybobbins"
      Project     = local.name
    }
  }
}

provider "kubernetes" {
  # host                   = module.eks.cluster_endpoint
  # cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   command     = "aws"
  #   # This requires the awscli to be installed locally where Terraform is executed
  #   args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  # }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

terraform {
  backend "s3" {
    bucket = var.state_bucket
    key    = var.common_tags.Project
    region = var.aws_region
  }
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.15.0"
    }
  }
}