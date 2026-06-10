<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.75.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.75.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | terraform-aws-modules/cloudfront/aws | ~> 6.3 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_cloudfront_origin_request_policy.websocket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_request_policy) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_s3_bucket_policy.static_site_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_cloudfront_cache_policy.caching_optimized](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_cache_policy) | data source |
| [aws_cloudfront_cache_policy.no_caching](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_cache_policy) | data source |
| [aws_cloudfront_origin_request_policy.pass_all_headers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_origin_request_policy) | data source |
| [aws_cloudfront_response_headers_policy.security_headers_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_response_headers_policy) | data source |
| [aws_iam_policy_document.s3_static_site_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_backend_domain_name"></a> [backend\_domain\_name](#input\_backend\_domain\_name) | Origin domain name for the API/backend load balancer. | `string` | n/a | yes |
| <a name="input_backend_origin_verify_header"></a> [backend\_origin\_verify\_header](#input\_backend\_origin\_verify\_header) | Custom header CloudFront sends to the ALB so only edge traffic is forwarded to the backend. | `map(string)` | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ARN of the ACM certificate for HTTPS on the distribution. | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Alternate domain name (CNAME) for the CloudFront distribution. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name prefix for the CloudFront distribution and related resources. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region (used for Lambda@Edge and ACM certificate lookup). | `string` | n/a | yes |
| <a name="input_static_sites"></a> [static\_sites](#input\_static\_sites) | Static-site origins (S3 + Lambda@Edge URL rewriter) fanned out from the CloudFront distribution. Exactly one entry must have path\_pattern = null; it becomes the default cache behavior. | <pre>map(object({<br/>    bucket      = string<br/>    bucket_arn  = string<br/>    domain_name = string<br/>    lambda_arn  = optional(string)<br/>    # CloudFront path pattern (e.g. "/scratch*"). Omit (null) on exactly one<br/>    # entry to designate it as the default behavior served at "/".<br/>    path_pattern = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to CloudFront resources. | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->