# attach a policy to the role that allows ECR access

# create a policy template
data "aws_iam_policy_document" "deploy" {

  statement {
    effect = "Allow"
    actions = [
      # ECR permissions
      # allow pushing new ECR images
      # https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazonelasticcontainerregistry.html
      # https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-push-iam.html
      "ecr:CompleteLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:BatchGetImage",
    ]
    resources = var.ecr_repository_arns
  }

  statement {
    effect = "Allow"
    actions = [
      # and updating / re-deploying a service
      "ecs:UpdateService",
    ]
    resources = var.ecs_service_arns
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"]
  }

  # S3 permissions
  # allow reading and writing to the S3 bucket
  # https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_s3_rw-bucket.html

  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = var.s3_bucket_arns
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:*Object",
      "s3:ListMultipartUploadParts",
      "s3:GetObjectVersion",
      "s3:GetObjectTagging",
    ]
    resources = [for arn in var.s3_bucket_arns : "${arn}/*"]
  }
}

# an instance of that policy
resource "aws_iam_policy" "deploy" {
  name        = "ci-deploy-policy-${var.github_account_name}-${var.github_repo_name}-${var.environment}"
  description = "Policy used for deployments on CI"
  policy      = data.aws_iam_policy_document.deploy.json

  tags = var.tags
}

# and attach it to the role
resource "aws_iam_role_policy_attachment" "attach_deploy" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.deploy.arn
}
