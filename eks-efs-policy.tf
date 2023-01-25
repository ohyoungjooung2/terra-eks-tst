# resource "aws_iam_policy" "eks-efs-driver-policy"{
#   name = "eks-efs-driver-policy"
#   path = "/"
#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#         "Effect": "Allow",
#         "Action": [
#             "elasticfilesystem:DescribeAccessPoints",
#             "elasticfilesystem:DescribeFileSystems"
#         ],
#         "Resource": "*"
#         },
#         {
#         "Effect": "Allow",
#         "Action": [
#             "elasticfilesystem:CreateAccessPoint"
#         ],
#         "Resource": "*",
#         "Condition": {
#             "StringLike": {
#             "aws:RequestTag/efs.csi.aws.com/cluster": "true"
#             }
#         }
#         },
#         {
#         "Effect": "Allow",
#         "Action": "elasticfilesystem:DeleteAccessPoint",
#         "Resource": "*",
#         "Condition": {
#             "StringEquals": {
#             "aws:ResourceTag/efs.csi.aws.com/cluster": "true"
#             }
#         }
#         }
#     ]
#     })
#  }

#  #Get current id

# resource "aws_iam_role" "eks-efs-driver-role" {
#     name = "eks-efs-driver-role"
#     assume_role_policy = <<POLICY
# {
#         "Version": "2012-10-17",
#         "Statement": [
#             {
#             "Effect": "Allow",
#             "Principal": {
#                 "Federated": "${aws_iam_openid_connect_provider.tst-eks.id}"
#             },
#             "Action": "sts:AssumeRoleWithWebIdentity",
#             "Condition": {
#                 "StringEquals": {
#                 "${replace(aws_iam_openid_connect_provider.tst-eks.url, "https://", "")}:sub": "system:serviceaccount:kube-system:efs-csi-controller-sa"
#                  }
#             }
#           }
#         ]
#     }
#      POLICY
# }


# resource "aws_iam_role_policy_attachment" "attch-efs-driver-policy-to-role" {
#   policy_arn = aws_iam_policy.eks-efs-driver-policy.arn
#   role       = aws_iam_role.eks-efs-driver-role.name
# }

