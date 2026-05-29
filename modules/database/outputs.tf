output "url_arn" {
  description = "ARN of the Secrets Manager secret containing the database connection URL."
  value       = aws_secretsmanager_secret.database_url.arn
}

output "user" {
  description = "Database username"
  value       = local.database_user
}

output "password_arn" {
  description = "ARN of the Secrets Manager secret containing the database password"
  value       = aws_secretsmanager_secret.database_pwd.arn
}

output "host" {
  description = "Database hostname"
  value       = module.database.db_instance_address
}

output "port" {
  description = "Database port"
  value       = local.database_port
}

output "name" {
  description = "Database name"
  value       = local.database_name
}
