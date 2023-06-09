<img src="./assets/TEKsystems_brandmark_CMYK.png"
     alt="Teksystems brandmark"
     style="margin-right: 10px; height: 50px;" />
<img src="./assets/GS_Stacked_Edited.png"
     alt="Teksystems GS logo"
     style="margin-right: 10px; width: 130px;" />

<br/>
<br/>

# EKS TF POC Module for Platform Agility within Business Modernization

## Description
This is a Terraform accelerator including a module that builds a proof of concept (POC) Elastic Kubernetes Service (EKS) cluster.

## Table of Contents
* [Requirements](#requirements)
* [Providers](#providers)
* [Modules](#modules)
* [Inputs](#inputs)
* [Outputs](#outputs)
* [Installation](#installation)
* [Usage](#usage)
* [License](#license)
* [Cluster Specs](#cluster-specs)
* [Contributing](#contributing)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_cluster"></a> [eks\_cluster](#module\_eks\_cluster) | ./module | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | Enter a profile name to deploy infrastructure into | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Enter a region id to deploy infrastruction into | `string` | `"us-east-1"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name you would like to prefix your resources | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_cluster_name_arn"></a> [master\_cluster\_name\_arn](#output\_master\_cluster\_name\_arn) | The name and arn of the master-cluster |

## Installation
Needed to run:

Terraform: [download version .12 and above](https://www.terraform.io/downloads)

An AWS account with IAM permissions. 

[Configured AWS CLI](https://learn.hashicorp.com/tutorials/terraform/eks)

[kubectl](https://kubernetes.io/docs/tasks/tools/)

## Usage
Update variable files.

backend-state/variable.tf
   
         - input default values for empty values
         - accelerator_name must not have uppercase values or any puntucation other than dashes

variable.tf
   
         - input default values for empty values
         - name must not have uppercase values or any puntucation other than dashes

A S3 bucket must be set up for the backend state, the terraform.tfstate file. This allows security and collaboration. Within the backend-state folder run in command line:

         terraform init
         terraform plan
         terraform apply

Once the bucket is created, return to the root folder 

Inside of main.tf in the root folder, some values need to be input within the backend "s3" {} resource

        Update bucket name to your bucket's name
        Update region to desired region
        Update profile to your profile

Within your main.tf, you need to include this block of code.

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
          eni_name = "${var.name}${count.index}-eni"
          node_group_name = "${var.name}${count.index}-node-group"
          worker_nodes_role_name = "${var.name}${count.index}-worker-nodes-role"
          master_cluster_role_name = "${var.name}${count.index}-master-cluster-role"
          worker_node_instance_profile_name = "${var.name}${count.index}-worker-node-instance-profile"
          editor = var.editor
     }

For it to run, you need to create a variable in your variable.tf folder called name.

    variable "name" {
    description = "The name you would like to prefix your resources"
    default = ""
    }

Run in command line:

    terraform init
    terraform plan
    terraform apply


## License
© 2022 TEKsystems Global Services, LLC ALL RIGHTS RESERVED.


## Cluster Specs
Specs for the EKS cluster created

*  Single cluster
* 1 region:
     - us-east-1
* 3 Availability zones:
     - us-east-1a
     - us-east-1b
     - us-east-1c
* Worker Nodes
     - 3 nodes
     - a1.large instance type
* Cloudwatch logging

## Contributing
No contributors allowed.


