module "github-oidc" {
 source  = "terraform-module/github-oidc-provider/aws"
 version = "~> 1"

 role_name = "github-oidc-provider-${var.common_tags.Project}-${var.common_tags.env}"
 create_oidc_provider = true
 create_oidc_role     = true

 repositories              = [var.github_repository]
 oidc_role_attach_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}