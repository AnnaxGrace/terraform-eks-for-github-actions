terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  #cannot use variables
  backend "s3" {
    bucket         = "backend-state-for-github-actions"
    key            = "github-actions/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "backend-lock-for-github-actions"
    encrypt        = true
    profile        = "anna-account"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module eks_cluster {
    count = 1
    source = "./module"
    master_cluster_name = "${var.name}${count.index}-master-cluster"
    cloudwatch_log_group_name = "/aws/eks/${var.name}${count.index}-master-cluster/cluster"
    internet_gateway_name = "${var.name}${count.index}-internet-gateway"
    nat_gateway_name = "${var.name}${count.index}-nat-gateway"
    master_cluster_sg_name = "${var.name}${count.index}-master-cluster-sg"
    worker_node_sg_name = "${var.name}${count.index}-worker-node-sg"
    vpc_name = "${var.name}${count.index}-vpc"
    eip_name = "${var.name}${count.index}-eip"
    eni_name = "${var.name}${count.index}-eip"
    node_group_name = "${var.name}${count.index}-node-group"
    worker_nodes_role_name = "${var.name}${count.index}-worker-nodes-role"
    master_cluster_role_name = "${var.name}${count.index}-master-cluster-role"
    worker_node_instance_profile_name = "${var.name}${count.index}-worker-node-instance-profile"
    editor = var.editor
}

output "master_cluster_name_arn" {
  value = module.eks_cluster 
}



