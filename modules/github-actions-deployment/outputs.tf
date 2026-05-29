output "role_arn" {
  description = "ARN of the IAM role assumed by GitHub Actions for deployments."
  value       = aws_iam_role.this.arn
}
