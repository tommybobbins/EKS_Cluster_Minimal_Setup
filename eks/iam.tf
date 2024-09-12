data "aws_iam_roles" "sso_admin" {
  name_regex = "AWSReservedSSO_AdministratorAccess.*"
}

data "aws_iam_role" "sso_admin" {
  count = length(data.aws_iam_roles.sso_admin.names)
  name  = sort(data.aws_iam_roles.sso_admin.names)[0]
}

data "aws_iam_roles" "github_oidc" {
  name_regex = ".*github-oidc-provider.*"
}

data "aws_iam_role" "github_oidc" {
  count = length(data.aws_iam_roles.github_oidc.names)
  name  = sort(data.aws_iam_roles.github_oidc.names)[0]
}

locals {
  sso_admin_arn   = one([data.aws_iam_role.sso_admin[0].arn])
  github_oidc_arn = one([data.aws_iam_role.github_oidc[0].arn])
}