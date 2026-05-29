locals {
  backend_name = "backend"
  backend_port = 3001
}

module "ecs_service" {
  source  = "terraform-aws-modules/ecs/aws//modules/service"
  version = "~> 7.3"

  name          = var.name
  desired_count = 1
  cluster_arn   = module.ecs_cluster.arn

  # Task Definition
  enable_execute_command    = true
  create_task_exec_iam_role = true
  create_task_exec_policy   = true
  task_exec_secret_arns = [
    var.database_connection_info.url_arn,
    var.database_connection_info.password_arn,
  ]

  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  container_definitions = {
    (local.backend_name) = {
      image                  = module.ecr_backend[var.backend_image_name].repository_url
      readonlyRootFilesystem = false

      healthCheck = {
        command = [
          "CMD-SHELL",
          "curl -f http://localhost:${local.backend_port}/${var.health_check_uri_path} || exit 1"
        ]
      }

      portMappings = [
        {
          protocol      = "tcp",
          containerPort = local.backend_port
        }
      ]
      environment = [
        {
          name  = "PORT",
          value = local.backend_port
        },
        {
          name  = "FRONTEND_HOSTNAME",
          value = "https://${var.domain_name}"
        },
        {
          name  = "OPEN_ID_CONNECT_JWK_ENDPOINT",
          value = "https://login.microsoftonline.com/common/discovery/v2.0/keys"
        },
        {
          name  = "OPEN_ID_CONNECT_USERINFO_ENDPOINT",
          value = "https://graph.microsoft.com/oidc/userinfo"
        },
        {
          name  = "OPEN_ID_CONNECT_MICROSOFT_CLIENT_ID",
          value = var.open_id_connect_microsoft_client_id
        },
        {
          name  = "SENTRY_DSN",
          value = var.sentry_dsn
        },
        {
          name  = "SENTRY_ENVIRONMENT",
          value = var.environment
        },
        {
          name  = "DB_HOST",
          value = var.database_connection_info.host
        },
        {
          name  = "DB_PORT",
          value = var.database_connection_info.port
        },
        {
          name  = "DB_USERNAME",
          value = var.database_connection_info.user
        },
        {
          name  = "DB_DATABASE",
          value = var.database_connection_info.name
        },
        {
          name  = "DB_SSL",
          value = "true"
        }
      ]
      secrets = [
        {
          name      = "DB_PASSWORD"
          valueFrom = var.database_connection_info.password_arn
        },
        {
          name      = "DB_URL"
          valueFrom = var.database_connection_info.url_arn
        }
      ]
    }
  }

  service_registries = {
    registry_arn = var.discovery_service_arn
  }

  load_balancer = {
    backend = {
      target_group_arn = module.alb.target_groups[local.backend_name].arn
      container_name   = local.backend_name
      container_port   = local.backend_port
    }
  }

  subnet_ids = var.private_subnet_ids
  security_group_ingress_rules = {
    ingress_alb_service = {
      from_port                    = local.backend_port
      to_port                      = local.backend_port
      ip_protocol                  = "tcp"
      description                  = "Backend"
      referenced_security_group_id = module.alb.security_group_id
    }
  }

  security_group_egress_rules = {
    egress_all = {
      # You may not specify all protocols and specific ports. Please specify each protocol
      # and port range combination individually, or all protocols and no port range.
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  tags = var.tags
}
