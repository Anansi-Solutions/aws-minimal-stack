variable "region" {
  type        = string
  description = "AWS region for IAM and deployment resources."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment (dev or prod)."

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "The environment can only be defined as 'dev' or 'prod'"
  }
}

variable "github_action_oidc_provider_domain" {
  type        = string
  default     = "token.actions.githubusercontent.com"
  description = "OIDC issuer domain for GitHub Actions workload identity."
}

variable "github_account_name" {
  type        = string
  description = "GitHub organization or user name that owns the repository."
}

variable "github_repo_name" {
  type        = string
  description = "GitHub repository name allowed to assume the deployment role."
}

variable "ecr_repository_arns" {
  type        = list(string)
  description = "ECR repository ARNs the deployment role may push images to."
}

variable "ecs_service_arns" {
  type        = list(string)
  description = "ECS service ARNs the deployment role may update."
}

variable "s3_bucket_arns" {
  type        = list(string)
  description = "S3 bucket ARNs the deployment role may upload static assets to."
}

variable "github_variables" {
  type        = map(string)
  description = "Repository-level GitHub Actions variables provisioned for this environment. Keys are auto-prefixed with the environment (e.g. DEV_AWS_REGION). Empty/null values are created as 'replace-me' placeholders and then left untouched."
}

variable "github_secrets" {
  type        = set(string)
  description = "Repository-level GitHub Actions secrets provisioned for this environment. Keys are auto-prefixed with the environment (e.g. DEV_MY_SECRET). Values are created as 'replace-me' placeholders and then left untouched."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to IAM and GitHub provider resources."
}
