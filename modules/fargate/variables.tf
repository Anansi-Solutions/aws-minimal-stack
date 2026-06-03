variable "name" {
  type        = string
  description = "Name prefix for Fargate resources (cluster, service, load balancer)."
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

variable "domain_name" {
  type        = string
  description = "Public DNS domain name for the backend load balancer."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to Fargate resources."
}

variable "region" {
  type        = string
  description = "AWS region where Fargate resources are deployed."
}

variable "private_dns_arn" {
  type        = string
  description = "ARN of the private Route 53 hosted zone for service discovery."
}

variable "database_connection_info" {
  description = "The connection information to the database"
  sensitive   = true
  type = object({
    host         = string
    port         = number
    user         = string
    password_arn = string
    name         = string
    url_arn      = string
  })
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for ECS tasks and internal load balancer."
}

variable "private_subnet_objects" {
  type = list(object({
    availability_zone = string
    cidr_block        = string
  }))
  description = "Private subnet metadata used for availability-zone-aware placement."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where Fargate resources are created."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs for the internet-facing load balancer."
}

variable "discovery_service_arn" {
  type        = string
  description = "ARN of the Cloud Map service for ECS service discovery."
}

variable "open_id_connect_microsoft_client_id" {
  type        = string
  description = "Microsoft Entra ID client ID for OIDC authentication."
}

variable "sentry_dsn" {
  type        = string
  description = "Sentry DSN injected into the backend container environment."
}

variable "backend_image_name" {
  type        = string
  description = "Container image name appended to the ECR repository (e.g. __PROJECT_NAME__-backend)."
}

variable "health_check_grace_period_seconds" {
  type        = number
  default     = 60
  description = "Seconds the ECS service ignores ALB health check failures after a task starts, giving the backend time to boot before unhealthy tasks are replaced. Default set to one hour due to potentially long startup time due to migrations."
}

variable "health_check_uri_path" {
  type        = string
  default     = "/api"
  description = "The URI of the health check endpoint on the backend, e.g. `/api/health`"
}