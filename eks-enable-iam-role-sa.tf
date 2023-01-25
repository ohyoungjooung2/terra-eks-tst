data "tls_certificate" "tst-eks" {
  url = aws_eks_cluster.tst-eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "tst-eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.tst-eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.tst-eks.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "tst-eks_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.tst-eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.tst-eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "tst-eks-for-sa" {
  assume_role_policy = data.aws_iam_policy_document.tst-eks_assume_role_policy.json
  name               = "tst-eks-for-sa"
}