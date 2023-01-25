# resource "aws_efs_file_system" "for-eks-sc"{
#     creation_token = "efs-for-eks"
#     encrypted = "true"
#     tags = {
#         Name = "efs-for-eks"
#     }
# }

# resource "aws_efs_mount_target" "mnt-for-eks-sc"{
#     file_system_id = aws_efs_file_system.for-eks-sc.id
#     subnet_id = aws_subnet.tst-eks2.id
#     security_groups = [aws_security_group.eks-efs-sg.id]

# }
# resource "aws_efs_mount_target" "mnt2-for-eks-sc"{
#     file_system_id = aws_efs_file_system.for-eks-sc.id
#     subnet_id = aws_subnet.tst-eks1.id
#     security_groups = [aws_security_group.eks-efs-sg.id]

# }