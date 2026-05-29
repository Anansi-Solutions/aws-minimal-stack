variable "name" {
  type        = string
  description = "Name prefix for the RDS instance and related resources."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment (dev or prod)."

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "The environment can only be defined as 'dev' or 'prod'"
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to database resources."
}

variable "region" {
  type        = string
  description = "AWS region where the database is deployed."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the database security group and subnet placement."
}

variable "private_subnets_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks of private subnets allowed to connect to the database."
}

variable "database_subnet_group_name" {
  type        = string
  description = "Name of the DB subnet group for RDS placement."
}
