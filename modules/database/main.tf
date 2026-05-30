locals {
  database_name = "__PROJECT_NAME__"
  database_user = "__PROJECT_NAME__"
  database_port = 5432
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = var.name
  description = "PostgreSQL database security group"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    for block in var.private_subnets_cidr_blocks :
    {
      from_port   = local.database_port
      to_port     = local.database_port
      protocol    = "tcp"
      description = "PostgreSQL access from within private subnet"
      cidr_blocks = block
    }
  ]

  tags = var.tags
}

resource "random_password" "database" {
  length  = 36
  special = false
}

module "database" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 7.2"

  identifier = var.name

  engine = "postgres"
  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/PostgreSQL.Concepts.General.DBVersions.html
  engine_version           = "18.3"
  engine_lifecycle_support = "open-source-rds-extended-support-disabled"
  family                   = "postgres18"
  major_engine_version     = "18"

  allow_major_version_upgrade = false

  storage_encrypted = true

  auto_minor_version_upgrade = true

  instance_class = "db.t3.micro"

  # DB instance storage - will be increased when needed
  storage_type          = "gp3"
  allocated_storage     = 5
  max_allocated_storage = 10

  db_name  = local.database_name
  username = local.database_user

  manage_master_user_password = false
  password_wo                 = random_password.database.result
  password_wo_version         = "1"
  port                        = tostring(local.database_port)

  multi_az = false

  db_subnet_group_name   = var.database_subnet_group_name
  vpc_security_group_ids = [module.security_group.security_group_id]

  # when AWS is allowed to perform maintenance
  maintenance_window = "Sat:00:00-Sat:06:00"

  # daily backup window - cannot overlap with the maintenance window
  backup_window           = "21:00-23:59"
  backup_retention_period = 7
  # create a final snapshot and prevent deletion, only if not dev
  skip_final_snapshot = var.environment == "dev"
  deletion_protection = var.environment != "dev"

  performance_insights_enabled    = true
  create_monitoring_role          = false
  enabled_cloudwatch_logs_exports = ["postgresql"]

  performance_insights_retention_period = 465

  parameters = [
    {
      # https://www.postgresql.org/docs/current/routine-vacuuming.html
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    },
    {
      name  = "log_min_duration_statement"
      value = "1000"
    },
    {
      name  = "log_statement"
      value = "none"
    }
  ]

  tags = var.tags
}

locals {
  database_url = sensitive("postgresql://${local.database_user}:${random_password.database.result}@${module.database.db_instance_address}:${local.database_port}/${local.database_name}?schema=public")
}

resource "aws_secretsmanager_secret" "database_url" {
  name = "${var.name}-url"

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "database_url" {
  secret_id     = aws_secretsmanager_secret.database_url.id
  secret_string = local.database_url
}

resource "aws_secretsmanager_secret" "database_pwd" {
  name = "${var.name}-password"

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "database_pwd" {
  secret_id     = aws_secretsmanager_secret.database_pwd.id
  secret_string = random_password.database.result
}
