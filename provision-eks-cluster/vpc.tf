variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "profile" {
  default     = "integrations"
  description = "Which local AWS profile to use"
}

variable "cluster_name" {
  description = "cluster base name"
}

provider "aws" {
  region = var.region
  profile = var.profile
}

data "aws_availability_zones" "available" {}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name                 = "${var.cluster_name}-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    Environment = "integration"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
    Owner       = "${var.cluster_name}"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
    Environment = "integration"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
    Owner       = "${var.cluster_name}"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
    Environment = "integration"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
    Owner       = "${var.cluster_name}"
  }
}
