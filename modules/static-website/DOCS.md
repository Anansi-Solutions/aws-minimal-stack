<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.34.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_archive"></a> [archive](#provider\_archive) | >= 2.0.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.34.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_spa_lambda_function"></a> [spa\_lambda\_function](#module\_spa\_lambda\_function) | terraform-aws-modules/lambda/aws | ~> 8.5 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [archive_file.lambda_function](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_lambda_function_output_zip"></a> [lambda\_function\_output\_zip](#input\_lambda\_function\_output\_zip) | Output path for the zipped Lambda@Edge deployment package. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix for the S3 bucket and related static-site resources. | `string` | n/a | yes |
| <a name="input_nodejs_lambda_function_path"></a> [nodejs\_lambda\_function\_path](#input\_nodejs\_lambda\_function\_path) | Path to the Node.js source file used as a Lambda@Edge handler to rewrite request URIs (SPA routing). | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region where the S3 bucket and Lambda@Edge function are created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to static website resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_bucket"></a> [bucket](#output\_bucket) | Name of the S3 bucket hosting the static site. |
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | ARN of the S3 bucket hosting the static site. |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | Regional domain name of the S3 bucket (used as a CloudFront origin). |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | ID of the S3 bucket hosting the static site. |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | Qualified ARN of the Lambda@Edge function for SPA URI rewriting. |
<!-- END_TF_DOCS -->