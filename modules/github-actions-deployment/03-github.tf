# configure GitHub Actions variables and secrets for the repository.
# Variables marked with a non-empty value are managed authoritatively;
# the rest are created with a `replace-me` placeholder and then left
# alone so a human can fill in the real value once.

locals {
  # Computed values that callers cannot know until this module runs.
  # Anything else the caller wants to publish goes through `var.github_variables`.
  github_variables_baseline = {
    AWS_REGION     = var.region
    ROLE_TO_ASSUME = aws_iam_role.this.arn
  }

  github_variables_merged = merge(var.github_variables, local.github_variables_baseline)

  github_variables_this = tomap({
    for k, v in local.github_variables_merged :
    k => v if v != "" && v != null
  })

  github_variables_placeholders = tomap({
    for k, v in local.github_variables_merged :
    k => "replace-me" if v == "" || v == null
  })
}

resource "github_actions_variable" "this" {
  for_each = local.github_variables_this

  repository = var.github_repo_name

  variable_name = "${upper(var.environment)}_${each.key}"
  value         = each.value
}

resource "github_actions_variable" "placeholders" {
  for_each = local.github_variables_placeholders

  repository = var.github_repo_name

  variable_name = "${upper(var.environment)}_${each.key}"
  value         = each.value

  lifecycle {
    ignore_changes = [value]
  }
}

resource "github_actions_secret" "placeholders" {
  for_each = var.github_secrets

  repository = var.github_repo_name

  secret_name     = "${upper(var.environment)}_${each.key}"
  plaintext_value = "replace-me"

  lifecycle {
    ignore_changes = [plaintext_value]
  }
}
