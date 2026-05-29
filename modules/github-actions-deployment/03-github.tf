# configure GitHub Actions variables and secrets for the repository.
# Variables marked with a non-empty value are managed authoritatively;
# the rest are created with a `replace-me` placeholder and then left
# alone so a human can fill in the real value once.

resource "github_actions_variable" "configured" {
  for_each = var.github_variables

  repository = var.github_repo_name

  variable_name = "${upper(var.environment)}_${each.key}"
  value         = each.value
}

resource "github_actions_variable" "aws_role" {
  repository = var.github_repo_name

  variable_name = "${upper(var.environment)}_ROLE_TO_ASSUME"
  value         = aws_iam_role.this.arn
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
