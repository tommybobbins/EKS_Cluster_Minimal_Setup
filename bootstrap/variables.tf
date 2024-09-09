variable "github_repository" {
  type    = string
  default = "<myuser_needs_adding_here/my_repository_needs_adding_here>"
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "common_tags" {
  type = map(any)
  default = {
    Project   = "eksmvp"
    ManagedBy = "terraform"
    env = "dev"
  }
}