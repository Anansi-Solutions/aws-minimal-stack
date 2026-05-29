variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC."
}

variable "name" {
  type        = string
  description = "Name prefix for network resources (VPC, DNS, certificates)."
}

variable "domain_name" {
  type        = string
  description = "Public DNS domain name for ACM certificate issuance."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to network resources."
}

variable "region" {
  type        = string
  description = "AWS region where the VPC and regional resources are created."
}
