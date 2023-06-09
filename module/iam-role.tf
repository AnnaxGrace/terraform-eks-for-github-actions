resource "aws_iam_role" "master_cluster_role_POC" {
  name               = var.master_cluster_role_name
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
        "Action": "sts:AssumeRole"
        }
    ]
}
    POLICY
  tags = merge(
    {
      "Name" = format("%s", var.master_cluster_role_name)
    },
    var.app_tags,
    local.module_tags
  )

}

resource "aws_iam_role_policy_attachment" "master_cluster_AmazonEKSClusterPolicy_POC" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.master_cluster_role_POC.name

}



resource "aws_iam_role_policy_attachment" "master_cluster_AmazonEKSServicePolicy_POC" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.master_cluster_role_POC.name

}

resource "aws_iam_role" "worker_node_role_POC" {

  name               = var.worker_nodes_role_name
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY

  tags = merge(
    {
      "Name" = format("%s", var.worker_nodes_role_name)
    },
    var.app_tags,
    local.module_tags
  )

}



resource "aws_iam_role_policy_attachment" "worker_node_AmazonEKSWorkerNodePolicy_POC" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker_node_role_POC.name

}



resource "aws_iam_role_policy_attachment" "worker_node_AmazonEKS_CNI_Policy_POC" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker_node_role_POC.name

}



resource "aws_iam_role_policy_attachment" "worker_node_AmazonEC2ContainerRegistryReadOnly_POC" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker_node_role_POC.name

}

resource "aws_iam_role_policy_attachment" "worker_node_CloudWatchAgentServerPolicy_POC" {

  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.worker_node_role_POC.name
}

resource "aws_iam_instance_profile" "worker_node_instance_profile_POC" {

  name = var.worker_node_instance_profile_name

  tags = merge(
    {
      "Name" = format("%s", var.worker_node_instance_profile_name)
    },
    var.app_tags,
    local.module_tags
  )

}
