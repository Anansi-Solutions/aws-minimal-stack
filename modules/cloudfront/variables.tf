variable "name" {
  type        = string
  description = "Name prefix for the CloudFront distribution and related resources."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to CloudFront resources."
}

variable "region" {
  type        = string
  description = "AWS region (used for Lambda@Edge and ACM certificate lookup)."
}

variable "domain_name" {
  type        = string
  description = "Alternate domain name (CNAME) for the CloudFront distribution."
}

variable "certificate_arn" {
  type        = string
  description = "ARN of the ACM certificate for HTTPS on the distribution."
}

variable "static_sites" {
  type = map(object({
    bucket      = string
    bucket_arn  = string
    domain_name = string
    lambda_arn  = optional(string)
    # CloudFront path pattern (e.g. "/scratch*"). Omit (null) on exactly one
    # entry to designate it as the default behavior served at "/".
    path_pattern = optional(string)
  }))
  description = "Static-site origins (S3 + Lambda@Edge URL rewriter) fanned out from the CloudFront distribution. Exactly one entry must have path_pattern = null; it becomes the default cache behavior."

  validation {
    condition     = length([for k, v in var.static_sites : k if v.path_pattern == null]) == 1
    error_message = "Exactly one entry in static_sites must have path_pattern = null (the default behavior)."
  }
}

variable "backend_domain_name" {
  type        = string
  description = "Origin domain name for the API/backend load balancer."
}
