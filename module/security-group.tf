resource "aws_security_group" "master_cluster_sg_POC" {

    name = var.master_cluster_sg_name
    description = "Cluster communication with worker nodes"
    vpc_id = aws_vpc.vpc_POC.id

    egress {

        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }

    tags = merge(
    {
      "Name" = format("%s-public", var.master_cluster_sg_name)
    },
    var.app_tags,
    local.module_tags
  )
}

#worker node security groups

resource "aws_security_group" "worker_node_sg_vpc_POC" {
  name        = var.worker_node_sg_name
  description = "Security group for all nodes in the cluster"
  vpc_id      = aws_vpc.vpc_POC.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      "Name" = format("%s-public", var.worker_node_sg_name)
    },
    var.app_tags,
    local.module_tags
  )
}

resource "aws_security_group_rule" "worker_node_ingress_self_POC" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.worker_node_sg_vpc_POC.id
  source_security_group_id = aws_security_group.worker_node_sg_vpc_POC.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker_node_ingress_cluster_https_POC" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker_node_sg_vpc_POC.id
  source_security_group_id = aws_security_group.master_cluster_sg_POC.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "worker_node_ingress_cluster_others_POC" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker_node_sg_vpc_POC.id
  source_security_group_id = aws_security_group.master_cluster_sg_POC.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "master_cluster_ingress-node_https_POC" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.master_cluster_sg_POC.id
  source_security_group_id = aws_security_group.worker_node_sg_vpc_POC.id
  to_port                  = 443
  type                     = "ingress"
}