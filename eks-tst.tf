resource "aws_eks_addon" "tst-eks-addon" {
  for_each = { for addon in var.addons : addon.name => addon }
  cluster_name = var.cluster-name
  addon_name   = each.value.name
  addon_version = each.value.version
  resolve_conflicts = "OVERWRITE"
   depends_on = [
    aws_iam_openid_connect_provider.tst-eks,
    aws_eks_node_group.tst-eks-node-grp,
  ]
}


resource "aws_eks_cluster" "tst-eks" {
  name     = var.cluster-name
  role_arn = aws_iam_role.tst-eks.arn


  vpc_config {
    subnet_ids = [aws_subnet.tst-eks1.id, aws_subnet.tst-eks2.id]
    endpoint_private_access = true
    endpoint_public_access = true
    security_group_ids = [aws_security_group.eks_sg.id]
  }

  version = var.cluster-version
  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.tst-eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.tst-eks-AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.tst-eks,
  ]
  enabled_cluster_log_types = ["api","audit","controllerManager","scheduler","authenticator"]
}

output "endpoint" {
  value = aws_eks_cluster.tst-eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.tst-eks.certificate_authority[0].data
}

resource "aws_cloudwatch_log_group" "tst-eks" {
    name = "/aws/eks/${var.cluster-name}/cluster"
    # retention_in_days = 0
}