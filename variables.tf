variable "name" {
  type        = string
  default     = "__PROJECT_NAME__"
  description = "Application name used as a prefix for resource naming."
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

variable "region" {
  type        = string
  description = "AWS region where infrastructure is deployed."
}

variable "domain_name" {
  type        = string
  description = "Public DNS domain name for the application."
}

variable "github_account_name" {
  type        = string
  description = "GitHub organization or user name that owns the repository."
}

variable "github_repo_name" {
  type        = string
  description = "GitHub repository name allowed to assume the deployment role."
}

variable "github_app_id" {
  type        = string
  description = "GitHub App ID, used for authentication."
}

variable "github_app_installation_id" {
  type        = string
  description = "GitHub App Installation ID, used for authentication."
}

variable "github_app_pem_file" {
  type        = string
  description = "GitHub App PEM file (private RSA key), used for authentication."
}

variable "sentry_dsn_backend" {
  type        = string
  description = "Sentry DSN for the backend service."
}

variable "sentry_dsn_frontend" {
  type        = string
  description = "Sentry DSN for the frontend static site."
}

variable "entra_id_client_id" {
  type        = string
  description = "Microsoft Entra ID application (client) ID for OIDC authentication."
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC."
}

variable "tags" {
  type = map(string)
  default = {
    ManagedBy = "OpenTofu/Scalr"
  }
  description = "Default tags applied to all resources."
}
