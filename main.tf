locals {
  tags = merge(var.tags, {
    Application = var.name
    Environment = var.environment
  })

  backend_image = "${var.name}-backend"
  backend_name  = "${var.name}-${var.environment}-backend"

  lambda_function_output_directory = "./lambdas/build"
}

module "network" {
  source = "./modules/network"

  name        = "${var.name}-${var.environment}-network"
  region      = var.region
  vpc_cidr    = var.vpc_cidr
  domain_name = var.domain_name

  tags = local.tags
}

module "frontend" {
  source = "./modules/static-website"

  # tflint-ignore: aws_s3_bucket_name
  name        = "${var.name}-${var.environment}-frontend"
  region      = var.region
  environment = var.environment

  nodejs_lambda_function_path = "./lambdas/src/frontend/index.mjs"
  lambda_function_output_zip  = "${local.lambda_function_output_directory}/frontend.zip"

  tags = local.tags
}

module "database" {
  source = "./modules/database"

  name        = "${var.name}-${var.environment}-database"
  region      = var.region
  environment = var.environment

  vpc_id                      = module.network.vpc_id
  database_subnet_group_name  = module.network.database_subnet_group_name
  private_subnets_cidr_blocks = module.network.private_subnets_cidr_blocks

  tags = local.tags
}

module "backend" {
  source = "./modules/fargate"

  name        = local.backend_name
  environment = var.environment
  domain_name = var.domain_name
  region      = var.region

  vpc_id                 = module.network.vpc_id
  discovery_service_arn  = module.network.discovery_service_arn
  private_dns_arn        = module.network.private_dns_arn
  private_subnet_ids     = module.network.private_subnet_ids
  private_subnet_objects = module.network.private_subnet_objects
  public_subnet_ids      = module.network.public_subnet_ids

  open_id_connect_microsoft_client_id = var.entra_id_client_id
  sentry_dsn                          = var.sentry_dsn_backend

  database_connection_info = {
    host         = module.database.host
    port         = module.database.port
    user         = module.database.user
    password_arn = module.database.password_arn
    name         = module.database.name
    url_arn      = module.database.url_arn
  }

  backend_image_name = local.backend_image

  tags = local.tags
}

module "cdn" {
  source = "./modules/cloudfront"

  name        = "${var.name}-${var.environment}-cdn"
  region      = var.region
  domain_name = var.domain_name

  static_sites = {
    frontend = {
      bucket      = module.frontend.bucket
      bucket_arn  = module.frontend.bucket_arn
      domain_name = module.frontend.bucket_domain_name
      lambda_arn  = module.frontend.lambda_arn
      # path_pattern omitted => served as the default behavior
      # path_pattern = "/*"
    }
  }

  backend_domain_name          = module.backend.dns_name
  backend_origin_verify_header = module.backend.origin_verify_header
  certificate_arn              = module.network.certificate_arn

  tags = local.tags
}

module "github_access" {
  source = "./modules/github-actions-deployment"

  github_app_id              = var.github_app_id
  github_app_installation_id = var.github_app_installation_id
  github_app_pem_file        = var.github_app_pem_file

  region      = var.region
  environment = var.environment

  github_account_name = var.github_account_name
  github_repo_name    = var.github_repo_name

  ecr_repository_arns = module.backend.repository_arns
  ecs_service_arns    = [module.backend.service_arn]
  s3_bucket_arns = [
    module.frontend.bucket_arn,
  ]

  github_variables = {
    AWS_REGION               = var.region
    DEPLOY_URL               = "https://${var.domain_name}"
    BACKEND_IMAGE_NAME       = local.backend_image
    BACKEND_CLUSTER_NAME     = local.backend_name
    BACKEND_SERVICE_NAME     = local.backend_name
    BACKEND_ECR_REGISTRY_URI = module.backend.repository_url_by_image[local.backend_image]
    FRONTEND_BUCKET_ID       = module.frontend.bucket_id
    ENTRA_ID_CLIENT_ID       = var.entra_id_client_id

    BACKEND_SENTRY_DSN  = var.sentry_dsn_backend
    FRONTEND_SENTRY_DSN = var.sentry_dsn_frontend
  }

  github_secrets = toset([
    "SENTRY_AUTH_TOKEN",
    "SONAR_TOKEN"
  ])

  tags = local.tags
}
