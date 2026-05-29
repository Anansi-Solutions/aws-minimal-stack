variable "name" {
  type        = string
  description = "Name prefix for the S3 bucket and related static-site resources."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to static website resources."
}

variable "region" {
  type        = string
  description = "AWS region where the S3 bucket and Lambda@Edge function are created."
}

variable "nodejs_lambda_function_path" {
  type        = string
  default     = ""
  description = "Path to the Node.js source file used as a Lambda@Edge handler to rewrite request URIs (SPA routing)."
}

variable "lambda_function_output_zip" {
  type        = string
  default     = ""
  description = "Output path for the zipped Lambda@Edge deployment package."
}
