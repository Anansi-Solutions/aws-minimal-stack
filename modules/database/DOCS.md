<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.30.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.30.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_database"></a> [database](#module\_database) | terraform-aws-modules/rds/aws | ~> 7.2 |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 5.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_secretsmanager_secret.database_pwd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.database_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.database_pwd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.database_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.database](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_database_storage_in_gb"></a> [database\_storage\_in\_gb](#input\_database\_storage\_in\_gb) | Size of the database to be allocated. | `number` | n/a | yes |
| <a name="input_database_storage_margin_in_gb"></a> [database\_storage\_margin\_in\_gb](#input\_database\_storage\_margin\_in\_gb) | Extra space to allow for database growth. | `number` | `5` | no |
| <a name="input_database_subnet_group_name"></a> [database\_subnet\_group\_name](#input\_database\_subnet\_group\_name) | Name of the DB subnet group for RDS placement. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment (dev or prod). | `string` | `"dev"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix for the RDS instance and related resources. | `string` | n/a | yes |
| <a name="input_private_subnets_cidr_blocks"></a> [private\_subnets\_cidr\_blocks](#input\_private\_subnets\_cidr\_blocks) | CIDR blocks of private subnets allowed to connect to the database. | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region where the database is deployed. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to database resources. | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for the database security group and subnet placement. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_host"></a> [host](#output\_host) | Database hostname |
| <a name="output_name"></a> [name](#output\_name) | Database name |
| <a name="output_password_arn"></a> [password\_arn](#output\_password\_arn) | ARN of the Secrets Manager secret containing the database password |
| <a name="output_port"></a> [port](#output\_port) | Database port |
| <a name="output_url_arn"></a> [url\_arn](#output\_url\_arn) | ARN of the Secrets Manager secret containing the database connection URL. |
| <a name="output_user"></a> [user](#output\_user) | Database username |
<!-- END_TF_DOCS -->