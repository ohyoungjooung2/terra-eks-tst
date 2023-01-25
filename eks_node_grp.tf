resource "aws_eks_node_group" "tst-eks-node-grp" {
  cluster_name    = var.cluster-name
  node_group_name = "tst-eks-node-grp1"
  node_role_arn   = aws_iam_role.tst-eks-iam-for-node.arn
  subnet_ids      = [aws_subnet.tst-eks1.id,aws_subnet.tst-eks2.id]

  remote_access {
    #ec2_ssh_key = aws_key_pair.dev_pub
    ec2_ssh_key = "dev_pub"
    source_security_group_ids = [aws_security_group.eks_node_sg.id,aws_security_group.eks_sg.id]
  }

  disk_size = 10
  instance_types = ["t3.small"]
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  # update_config {
  #   max_unavailable = 2
  # }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.tst-eks-iam-for-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.tst-eks-iam-for-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.tst-eks-iam-for-node-AmazonEC2ContainerRegistryReadOnly,
    aws_eks_cluster.tst-eks,
  ]

  #  # Optional: Allow external changes without Terraform plan difference
  # lifecycle {
  #   ignore_changes = [scaling_config[0].desired_size]
  # }

  timeouts {
    create = "60m"

  }
}