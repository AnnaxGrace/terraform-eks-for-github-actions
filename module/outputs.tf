output "cluster_name_arn" {
  value = [
    aws_eks_cluster.master_cluster_POC.arn,
    aws_eks_cluster.master_cluster_POC.name 
  ]
}
