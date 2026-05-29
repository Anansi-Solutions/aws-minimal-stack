terraform {
  required_version = ">= 1.5"

  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.34.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "aws" {
  # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/cnames-and-https-requirements.html
  # https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html#acm-regions
  # Lambda@Edge functions must live in us-east-1.
  region = "us-east-1"
  alias  = "cloudfront_region_provider"
}