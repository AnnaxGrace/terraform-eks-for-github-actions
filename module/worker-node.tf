resource "aws_eks_node_group" "worker-nodes-POC" {
  cluster_name    = aws_eks_cluster.master_cluster_POC.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.worker_node_role_POC.arn
  subnet_ids      = aws_subnet.subnet_private_POC[*].id
  instance_types  = var.worker_nodes_instance_types
  ami_type        = var.worker_nodes_ami_type

  scaling_config {
    desired_size = var.worker_nodes_desired_size
    max_size     = var.worker_nodes_maximum_size
    min_size     = var.worker_nodes_minimum_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker_node_AmazonEKSWorkerNodePolicy_POC,
    aws_iam_role_policy_attachment.worker_node_AmazonEKS_CNI_Policy_POC,
    aws_iam_role_policy_attachment.worker_node_AmazonEC2ContainerRegistryReadOnly_POC
  ]

  tags = merge(
    {
      "Name" = format("%s", var.node_group_name)
    },
    var.app_tags,
    local.module_tags
  )

}
