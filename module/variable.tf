# VPC Variables ------------------------------------------------

variable "vpc_name" {
  description = "The tag of your virtual private cloud, and then numbered"
  type        = string
}

variable "internet_gateway_name" {
  description = "The tag of your internet gateways, and then numbered"
  type        = string
}

variable "nat_gateway_name" {
  description = "The tag of your nat gateways, and then numbered"
  type        = string
}

variable "subnet_azs" {
  description = "Enter the availability zones for your subnets"
  type        = list(any)
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
}

variable "public_subnet_count" {
  description = "Enter the number of public subnets you are creating (advised is 3)"
  type        = number
  default     = 3
}

variable "private_subnet_count" {
  description = "Enter the number of private subnets you are creating (advised is 3)"
  type        = number
  default     = 3
}

variable "eip_name" {
  description = "The name of your eip, and then numbered"
  type        = string
}

variable "eni_name" {
  description = "The name of your eni, and then numbered"
  type        = string
}

# EKS Variables ------------------------------------------------
variable "master_cluster_name" {
  description = "The name of your master clusters, and then numbered"
  type        = string
}

variable "master_cluster_sg_name" {
  description = "The name of your master cluster security group, and then numbered"
  type        = string
}

variable "worker_node_sg_name" {
  description = "The name of your worker node security group, and then numbered"
  type        = string
}

variable "node_group_name" {
  description = "The name of your node group, and then numbered"
  type        = string
}

variable "worker_nodes_role_name" {
  description = "The name of your worker nodes roles, and then numbered"
  type        = string
}

variable "worker_nodes_instance_types" {
  description = "The instance type(s) of your worker nodes"
  type        = list(any)
  # default = ["a1.large"]
  default = ["t3.medium"]
}

variable "worker_nodes_ami_type" {
  description = "The ami type of your worker nodes"
  type        = string
  # default = "AL2_ARM_64"
  default = "AL2_x86_64"
}

variable "worker_nodes_desired_size" {
  description = "The number of worker nodes you'd like running"
  type        = number
  default     = 3
}

variable "worker_nodes_maximum_size" {
  description = "The maximum number of worker nodes you'd like running"
  type        = number
  default     = 3
}

variable "worker_nodes_minimum_size" {
  description = "The minimum number of worker nodes you'd like running"
  type        = number
  default     = 3
}

variable "master_cluster_role_name" {
  description = "The name of your master cluster roles, and then numbered"
  type        = string
}

variable "worker_node_instance_profile_name" {
  description = "The name of your worker nodes instance profiles, and then numbered"
  type        = string
}

variable "cloudwatch_log_group_name" {
  description = "The name of your cloudwatch log group name, and then numbered"
  type        = string
}

variable "cloudwatch_log_retention_days" {
  description = "The number of days you would like your cloudwatch log group to retain its logs"
  type        = number
  default     = 7
}

variable "master_cluster_enabled_log_types" {
  description = "List of the desired control plane logging to enable"
  type        = list(any)
  default     = ["api", "audit"]
}

# Tags ------------------------------------------------
variable "app_tags" {
  description = "Application specific tags."
  type        = map(any)
  default     = { "pod" = "platform agility" }
}

variable "editor" {
  description = "Enter the email ID of the person who is creating/editing this infrastructure."
  type        = string
}
