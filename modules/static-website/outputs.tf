output "bucket" {
  description = "Name of the S3 bucket hosting the static site."
  value       = aws_s3_bucket.this.bucket
}

output "bucket_id" {
  description = "ID of the S3 bucket hosting the static site."
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket hosting the static site."
  value       = aws_s3_bucket.this.arn
}

output "bucket_domain_name" {
  description = "Regional domain name of the S3 bucket (used as a CloudFront origin)."
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

output "lambda_arn" {
  description = "Qualified ARN of the Lambda@Edge function for SPA URI rewriting."
  value       = try(module.spa_lambda_function.lambda_function_qualified_arn, null)
}
