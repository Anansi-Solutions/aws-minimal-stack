<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.34.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_backend"></a> [backend](#module\_backend) | ./modules/fargate | n/a |
| <a name="module_cdn"></a> [cdn](#module\_cdn) | ./modules/cloudfront | n/a |
| <a name="module_database"></a> [database](#module\_database) | ./modules/database | n/a |
| <a name="module_frontend"></a> [frontend](#module\_frontend) | ./modules/static-website | n/a |
| <a name="module_github_access"></a> [github\_access](#module\_github\_access) | ./modules/github-actions-deployment | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_database_storage_in_gb"></a> [database\_storage\_in\_gb](#input\_database\_storage\_in\_gb) | Size of the database to be allocated. | `number` | n/a | yes |
| <a name="input_database_storage_margin_in_gb"></a> [database\_storage\_margin\_in\_gb](#input\_database\_storage\_margin\_in\_gb) | Extra space to allow for database growth. | `number` | `5` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Public DNS domain name for the application. | `string` | n/a | yes |
| <a name="input_entra_id_client_id"></a> [entra\_id\_client\_id](#input\_entra\_id\_client\_id) | Microsoft Entra ID application (client) ID for OIDC authentication. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment (dev or prod). | `string` | `"dev"` | no |
| <a name="input_github_account_name"></a> [github\_account\_name](#input\_github\_account\_name) | GitHub organization or user name that owns the repository. | `string` | n/a | yes |
| <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id) | GitHub App ID, used for authentication. | `string` | n/a | yes |
| <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id) | GitHub App Installation ID, used for authentication. | `string` | n/a | yes |
| <a name="input_github_app_pem_file"></a> [github\_app\_pem\_file](#input\_github\_app\_pem\_file) | GitHub App PEM file (private RSA key), used for authentication. | `string` | n/a | yes |
| <a name="input_github_repo_name"></a> [github\_repo\_name](#input\_github\_repo\_name) | GitHub repository name allowed to assume the deployment role. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Application name used as a prefix for resource naming. | `string` | `"__PROJECT_NAME__"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region where infrastructure is deployed. | `string` | n/a | yes |
| <a name="input_sentry_dsn_backend"></a> [sentry\_dsn\_backend](#input\_sentry\_dsn\_backend) | Sentry DSN for the backend service. | `string` | n/a | yes |
| <a name="input_sentry_dsn_frontend"></a> [sentry\_dsn\_frontend](#input\_sentry\_dsn\_frontend) | Sentry DSN for the frontend static site. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags applied to all resources. | `map(string)` | <pre>{<br/>  "ManagedBy": "OpenTofu/Scalr"<br/>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC. | `string` | `"10.0.0.0/16"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->