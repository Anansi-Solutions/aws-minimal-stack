data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

# To avoid production and development deployments in the same tenant from colliding,
# the following resource, which allows github actions to provide identities to AWS,
# needs to be deployed manually.
#
# resource "aws_iam_openid_connect_provider" "this" {
#   url = "https://${var.github_action_oidc_provider_domain}"
#
#   client_id_list = [
#     "sts.amazonaws.com",
#   ]
#
#   # Mandatory field but not used - we don't want to pin the certificate, we trust the domain.
#   thumbprint_list = ["ffffffffffffffffffffffffffffffffffffffff"]
#
#   tags = var.tags
# }

# create a role that github actions will assume
data "aws_iam_policy_document" "oidc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"
      identifiers = [provider::aws::arn_build(
        "aws", "iam", "", local.account_id,
        "oidc-provider/${var.github_action_oidc_provider_domain}"
      )]
    }

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    condition {
      test = "StringLike"
      # allow one repo within the organization to assume the role
      # but allow all branches - replace the * with a branch name if needed
      values   = ["repo:${var.github_account_name}/${var.github_repo_name}:${var.environment == "prod" ? "production" : "main"}"]
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "github-oidc-role-${var.github_account_name}-${var.github_repo_name}-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.oidc.json

  tags = var.tags
}
