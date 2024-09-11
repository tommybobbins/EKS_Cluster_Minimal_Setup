
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

locals {
  name = "ex-${replace(basename(path.cwd), "_", "-")}"
}

variable "gateway_flavour" {
  description = "Gateway API / Ingress Flavour to use (kong or nginx)"
  type        = string
  default     = "kong"
}

variable "gateway_api" {
  description = "Use Gateway API or Ingress"
  type        = bool
  default     = true
}