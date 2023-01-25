resource "aws_iam_role" "tst-eks-iam-for-node" {
  name = "eks-node-group-tst-eks-iam-for-node"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "tst-eks-iam-for-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.tst-eks-iam-for-node.name
}

resource "aws_iam_role_policy_attachment" "tst-eks-iam-for-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.tst-eks-iam-for-node.name
}

resource "aws_iam_role_policy_attachment" "tst-eks-iam-for-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.tst-eks-iam-for-node.name
}