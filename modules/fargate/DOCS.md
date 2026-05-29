<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.75.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.42.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | ~> 9.0 |
| <a name="module_ecr_backend"></a> [ecr\_backend](#module\_ecr\_backend) | terraform-aws-modules/ecr/aws | ~> 3.2 |
| <a name="module_ecs_cluster"></a> [ecs\_cluster](#module\_ecs\_cluster) | terraform-aws-modules/ecs/aws//modules/cluster | ~> 7.3 |
| <a name="module_ecs_service"></a> [ecs\_service](#module\_ecs\_service) | terraform-aws-modules/ecs/aws//modules/service | ~> 7.3 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_backend_image_name"></a> [backend\_image\_name](#input\_backend\_image\_name) | Container image name appended to the ECR repository (e.g. \_\_PROJECT\_NAME\_\_-backend). | `string` | n/a | yes |
| <a name="input_database_connection_info"></a> [database\_connection\_info](#input\_database\_connection\_info) | The connection information to the database | <pre>object({<br/>    host         = string<br/>    port         = number<br/>    user         = string<br/>    password_arn = string<br/>    name         = string<br/>    url_arn      = string<br/>  })</pre> | n/a | yes |
| <a name="input_discovery_service_arn"></a> [discovery\_service\_arn](#input\_discovery\_service\_arn) | ARN of the Cloud Map service for ECS service discovery. | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Public DNS domain name for the backend load balancer. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment (dev or prod). | `string` | n/a | yes |
| <a name="input_health_check_grace_period_seconds"></a> [health\_check\_grace\_period\_seconds](#input\_health\_check\_grace\_period\_seconds) | Seconds the ECS service ignores ALB health check failures after a task starts, giving the backend time to boot before unhealthy tasks are replaced. Default set to one hour due to potentially long startup time due to migrations. | `number` | `60` | no |
| <a name="input_health_check_uri_path"></a> [health\_check\_uri\_path](#input\_health\_check\_uri\_path) | The URI of the health check endpoint on the backend, e.g. `/api/health` | `string` | `"/api"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix for Fargate resources (cluster, service, load balancer). | `string` | n/a | yes |
| <a name="input_open_id_connect_microsoft_client_id"></a> [open\_id\_connect\_microsoft\_client\_id](#input\_open\_id\_connect\_microsoft\_client\_id) | Microsoft Entra ID client ID for OIDC authentication. | `string` | n/a | yes |
| <a name="input_private_dns_arn"></a> [private\_dns\_arn](#input\_private\_dns\_arn) | ARN of the private Route 53 hosted zone for service discovery. | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Private subnet IDs for ECS tasks and internal load balancer. | `list(string)` | n/a | yes |
| <a name="input_private_subnet_objects"></a> [private\_subnet\_objects](#input\_private\_subnet\_objects) | Private subnet metadata used for availability-zone-aware placement. | <pre>list(object({<br/>    availability_zone = string<br/>    cidr_block        = string<br/>  }))</pre> | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | Public subnet IDs for the internet-facing load balancer. | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region where Fargate resources are deployed. | `string` | n/a | yes |
| <a name="input_sentry_dsn"></a> [sentry\_dsn](#input\_sentry\_dsn) | Sentry DSN injected into the backend container environment. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to Fargate resources. | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where Fargate resources are created. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | DNS name of the application load balancer. |
| <a name="output_repository_arns"></a> [repository\_arns](#output\_repository\_arns) | List of ECR repository ARNs. |
| <a name="output_repository_url_by_image"></a> [repository\_url\_by\_image](#output\_repository\_url\_by\_image) | Map of the URLs of each ECR repository, by container image. |
| <a name="output_service_arn"></a> [service\_arn](#output\_service\_arn) | ARN of the ECS service running the backend. |
<!-- END_TF_DOCS -->