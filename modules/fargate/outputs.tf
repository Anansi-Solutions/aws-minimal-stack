output "repository_url_by_image" {
  description = "Map of the URLs of each ECR repository, by container image."
  value = {
    for k, r in module.ecr_backend :
    k => r.repository_url
  }
}

output "repository_arns" {
  description = "List of ECR repository ARNs."
  value = [
    for b in module.ecr_backend : b.repository_arn
  ]
}

output "service_arn" {
  description = "ARN of the ECS service running the backend."
  value       = module.ecs_service.id
}

output "dns_name" {
  description = "DNS name of the application load balancer."
  value       = module.alb.dns_name
}

output "origin_verify_header" {
  description = "Shared secret header CloudFront must send when connecting to the ALB backend origin."
  value = {
    name  = local.origin_verify_header_name
    value = random_password.origin_verify.result
  }
  sensitive = true
}
