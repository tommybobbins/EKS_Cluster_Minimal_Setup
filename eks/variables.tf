variable "instance_types" {
  description = "EKS Instance types"
  type        = list(any)
  default     = ["t3a.small", "t3a.medium", "t3a.large"]
}

variable "eks_default_nodegroup_types" {
  description = "Default node group EKS Instance types"
  type        = list(any)
  default     = ["t3.medium"]
}

variable "eks_version" {
  description = "EKS Version"
  default     = "1.30"
}

variable "vpc_cidr" {
  description = "CIDR for EKS cluster"
  default     = "10.123.0.0/16"
}

variable "eks_size" {
  description = "EKS Size (min,max,desired)"
  default     = ["1", "4", "3"]
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
    Project   = "eksmvp"
    ManagedBy = "terraform"
    env       = "dev"
  }
}

data "aws_caller_identity" "current" {}