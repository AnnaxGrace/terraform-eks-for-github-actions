terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

locals {
  last_edited_by = var.editor
  module_tags = {
    module_version                = "eks_POC:1.0"
    module_created_by             = "aconover@teksystems.com"
    module_owned_by               = "teksystems"
  }
}