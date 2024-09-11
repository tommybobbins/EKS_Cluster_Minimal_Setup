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
      source  = "opentofu/kubernetes"
      version = "2.32.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.15.0"
    }
  }
}