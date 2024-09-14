variable "wildcard_domain_name" {
  description = "Wildcard SSL certificate domain name"
  default     = "*.chegwin.org"
}

variable "aws_region" {
  description = "AWS Region"
  default     = "eu-west-2"
}

variable "state_bucket" {
  description = "Terraform State bucket"
}

variable "dynamo_tf_lock_table" {
  description = "DDB Terraform Lock table"
  default     = "terraform_state"
}

variable "common_tags" {
  description = "Default Resource Tags"
  type        = map(any)
  default = {
    Project   = "eksmvp-k8s"
    ManagedBy = "terraform"
    env       = "dev"
  }
}

data "aws_caller_identity" "current" {}

variable "gateway_flavour" {
  description = "Gateway API / Ingress Flavour to use (kong or nginx)"
  type        = string
  default     = "kong"
}

variable "kong_helm_version" {
  description = "Helm Chart version for KIC"
  type        = string
  default     = "2.41.1" #App Version 3.6
}

variable "kong_replicas" {
  description = "Min and Max number of pods for KIC"
  type        = map(any)
  default = {
    "min" = 1
    "max" = 2 # Developer mode
  }
}

variable "gateway_api" {
  description = "Use Gateway API or Ingress"
  type        = bool
  default     = true
}

data "aws_vpcs" "vpc" {
  tags = {
    Name = local.name
  }
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.vpc.ids[0]]
  }
  tags = {
    Tier = "Public"
  }
}

data "aws_acm_certificate" "ssl_cert" {
  domain   = var.wildcard_domain_name
  statuses = ["ISSUED"]
}
