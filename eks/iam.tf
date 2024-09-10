data "aws_iam_roles" "sso_admin" {
  name_regex = "AWSReservedSSO_AdministratorAccess.*"
}

data "aws_iam_role" "sso_admin" {
  count = length(data.aws_iam_roles.sso_admin.names)
  name  = sort(data.aws_iam_roles.sso_admin.names)[0]
}

locals {
  sso_admin_arn = "arn:aws:sts::${data.aws_caller_identity.current.account_id}:assumed-role/${split("/", (one([data.aws_iam_role.sso_admin[0].arn])))[3]}"
}