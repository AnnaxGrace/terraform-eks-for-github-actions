resource "aws_eks_cluster" "master_cluster_POC" {
  name     = var.master_cluster_name
  role_arn = aws_iam_role.master_cluster_role_POC.arn

  enabled_cluster_log_types = var.master_cluster_enabled_log_types

  vpc_config {
    subnet_ids         = aws_subnet.subnet_private_POC[*].id
    security_group_ids = [aws_security_group.master_cluster_sg_POC.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.master_cluster_AmazonEKSClusterPolicy_POC,
    aws_iam_role_policy_attachment.master_cluster_AmazonEKSServicePolicy_POC,
    aws_cloudwatch_log_group.cloudwatch_logs_POC
  ]

  tags = merge(
    {
        "Name" = format("%s", var.master_cluster_name)
    },
    var.app_tags,
    local.module_tags
  )
}
