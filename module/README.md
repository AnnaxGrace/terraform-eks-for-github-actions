<img src="./assets/TEKsystems_brandmark_CMYK.png"
     alt="Teksystems brandmark"
     style="margin-right: 10px; height: 50px;" />
<img src="./assets/GS_Stacked_Edited.png"
     alt="Teksystems GS logo"
     style="margin-right: 10px; width: 130px;" />

<br/>
<br/>

# EKS TF POC for Platform Agility within Business Modernization

## Description
This is a Terraform module that builds a proof of concept (POC) Elastic Kubernetes Service (EKS) cluster.
<br/>

## Table of Contents
* [Requirements](#requirements)
* [Providers](#providers)
* [Resources](#resources)
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

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.cloudwatch_logs_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_eip.eip_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eks_cluster.master_cluster_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.worker-nodes-POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_instance_profile.worker_node_instance_profile_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.master_cluster_role_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.worker_node_role_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.master_cluster_AmazonEKSClusterPolicy_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.master_cluster_AmazonEKSServicePolicy_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker_node_AmazonEC2ContainerRegistryReadOnly_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker_node_AmazonEKSWorkerNodePolicy_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker_node_AmazonEKS_CNI_Policy_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker_node_CloudWatchAgentServerPolicy_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_internet_gateway.igw_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.natgw_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_interface.eni_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_route.private_nat_gateway_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_internet_gateway_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.route_table_private_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.route_table_public_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.rta_private_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.rta_public_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.master_cluster_sg_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.worker_node_sg_vpc_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.master_cluster_ingress-node_https_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.worker_node_ingress_cluster_https_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.worker_node_ingress_cluster_others_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.worker_node_ingress_self_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.subnet_private_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.subnet_public_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc_POC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_tags"></a> [app\_tags](#input\_app\_tags) | Application specific tags. | `map(any)` | <pre>{<br>  "pod": "platform agility"<br>}</pre> | no |
| <a name="input_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#input\_cloudwatch\_log\_group\_name) | The name of your cloudwatch log group name, and then numbered | `string` | n/a | yes |
| <a name="input_cloudwatch_log_retention_days"></a> [cloudwatch\_log\_retention\_days](#input\_cloudwatch\_log\_retention\_days) | The number of days you would like your cloudwatch log group to retain its logs | `number` | `7` | no |
| <a name="input_editor"></a> [editor](#input\_editor) | Enter the email ID of the person who is creating/editing this infrastructure. | `string` | n/a | yes |
| <a name="input_eip_name"></a> [eip\_name](#input\_eip\_name) | The name of your eip, and then numbered | `string` | n/a | yes |
| <a name="input_eni_name"></a> [eni\_name](#input\_eni\_name) | The name of your eni, and then numbered | `string` | n/a | yes |
| <a name="input_internet_gateway_name"></a> [internet\_gateway\_name](#input\_internet\_gateway\_name) | The tag of your internet gateways, and then numbered | `string` | n/a | yes |
| <a name="input_master_cluster_enabled_log_types"></a> [master\_cluster\_enabled\_log\_types](#input\_master\_cluster\_enabled\_log\_types) | List of the desired control plane logging to enable | `list(any)` | <pre>[<br>  "api",<br>  "audit"<br>]</pre> | no |
| <a name="input_master_cluster_name"></a> [master\_cluster\_name](#input\_master\_cluster\_name) | The name of your master clusters, and then numbered | `string` | n/a | yes |
| <a name="input_master_cluster_role_name"></a> [master\_cluster\_role\_name](#input\_master\_cluster\_role\_name) | The name of your master cluster roles, and then numbered | `string` | n/a | yes |
| <a name="input_master_cluster_sg_name"></a> [master\_cluster\_sg\_name](#input\_master\_cluster\_sg\_name) | The name of your master cluster security group, and then numbered | `string` | n/a | yes |
| <a name="input_nat_gateway_name"></a> [nat\_gateway\_name](#input\_nat\_gateway\_name) | The tag of your nat gateways, and then numbered | `string` | n/a | yes |
| <a name="input_node_group_name"></a> [node\_group\_name](#input\_node\_group\_name) | The name of your node group, and then numbered | `string` | n/a | yes |
| <a name="input_private_subnet_count"></a> [private\_subnet\_count](#input\_private\_subnet\_count) | Enter the number of private subnets you are creating (advised is 3) | `number` | `3` | no |
| <a name="input_public_subnet_count"></a> [public\_subnet\_count](#input\_public\_subnet\_count) | Enter the number of public subnets you are creating (advised is 3) | `number` | `3` | no |
| <a name="input_subnet_azs"></a> [subnet\_azs](#input\_subnet\_azs) | Enter the availability zones for your subnets | `list(any)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b",<br>  "us-east-1c"<br>]</pre> | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The tag of your virtual private cloud, and then numbered | `string` | n/a | yes |
| <a name="input_worker_node_instance_profile_name"></a> [worker\_node\_instance\_profile\_name](#input\_worker\_node\_instance\_profile\_name) | The name of your worker nodes instance profiles, and then numbered | `string` | n/a | yes |
| <a name="input_worker_node_sg_name"></a> [worker\_node\_sg\_name](#input\_worker\_node\_sg\_name) | The name of your worker node security group, and then numbered | `string` | n/a | yes |
| <a name="input_worker_nodes_ami_type"></a> [worker\_nodes\_ami\_type](#input\_worker\_nodes\_ami\_type) | The ami type of your worker nodes | `string` | `"AL2_x86_64"` | no |
| <a name="input_worker_nodes_desired_size"></a> [worker\_nodes\_desired\_size](#input\_worker\_nodes\_desired\_size) | The number of worker nodes you'd like running | `number` | `3` | no |
| <a name="input_worker_nodes_instance_types"></a> [worker\_nodes\_instance\_types](#input\_worker\_nodes\_instance\_types) | The instance type(s) of your worker nodes | `list(any)` | <pre>[<br>  "t3.medium"<br>]</pre> | no |
| <a name="input_worker_nodes_maximum_size"></a> [worker\_nodes\_maximum\_size](#input\_worker\_nodes\_maximum\_size) | The maximum number of worker nodes you'd like running | `number` | `3` | no |
| <a name="input_worker_nodes_minimum_size"></a> [worker\_nodes\_minimum\_size](#input\_worker\_nodes\_minimum\_size) | The minimum number of worker nodes you'd like running | `number` | `3` | no |
| <a name="input_worker_nodes_role_name"></a> [worker\_nodes\_role\_name](#input\_worker\_nodes\_role\_name) | The name of your worker nodes roles, and then numbered | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name_arn"></a> [cluster\_name\_arn](#output\_cluster\_name\_arn) | The name and arn of the master-cluster |

## Installation
Needed to run:

Terraform: [download version .12 and above](https://www.terraform.io/downloads)

An AWS account with IAM permissions. 

[Configured AWS CLI](https://learn.hashicorp.com/tutorials/terraform/eks)

[kubectl](https://kubernetes.io/docs/tasks/tools/)

## Usage

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


