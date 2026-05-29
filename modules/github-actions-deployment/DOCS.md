<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.75.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.75.0 |
| <a name="provider_github"></a> [github](#provider\_github) | ~> 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_iam_policy.deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attach_deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [github_actions_secret.placeholders](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_variable.placeholders](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [github_actions_variable.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_ecr_repository_arns"></a> [ecr\_repository\_arns](#input\_ecr\_repository\_arns) | ECR repository ARNs the deployment role may push images to. | `list(string)` | n/a | yes |
| <a name="input_ecs_service_arns"></a> [ecs\_service\_arns](#input\_ecs\_service\_arns) | ECS service ARNs the deployment role may update. | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment (dev or prod). | `string` | `"dev"` | no |
| <a name="input_github_account_name"></a> [github\_account\_name](#input\_github\_account\_name) | GitHub organization or user name that owns the repository. | `string` | n/a | yes |
| <a name="input_github_action_oidc_provider_domain"></a> [github\_action\_oidc\_provider\_domain](#input\_github\_action\_oidc\_provider\_domain) | OIDC issuer domain for GitHub Actions workload identity. | `string` | `"token.actions.githubusercontent.com"` | no |
| <a name="input_github_repo_name"></a> [github\_repo\_name](#input\_github\_repo\_name) | GitHub repository name allowed to assume the deployment role. | `string` | n/a | yes |
| <a name="input_github_secrets"></a> [github\_secrets](#input\_github\_secrets) | Repository-level GitHub Actions secrets provisioned for this environment. Keys are auto-prefixed with the environment (e.g. DEV\_MY\_SECRET). Values are created as 'replace-me' placeholders and then left untouched. | `set(string)` | n/a | yes |
| <a name="input_github_variables"></a> [github\_variables](#input\_github\_variables) | Repository-level GitHub Actions variables provisioned for this environment. Keys are auto-prefixed with the environment (e.g. DEV\_AWS\_REGION). Empty/null values are created as 'replace-me' placeholders and then left untouched. | `map(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region for IAM and deployment resources. | `string` | n/a | yes |
| <a name="input_s3_bucket_arns"></a> [s3\_bucket\_arns](#input\_s3\_bucket\_arns) | S3 bucket ARNs the deployment role may upload static assets to. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to IAM and GitHub provider resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of the IAM role assumed by GitHub Actions for deployments. |
<!-- END_TF_DOCS -->