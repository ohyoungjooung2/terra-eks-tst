resource "aws_security_group" "eks-efs-sg" {
   name = "eks-efs-sg"
   description= "Allos inbound efs traffic from ec2(eks-node-grp)"
   vpc_id = aws_vpc.dev-vpc.id

   ingress {
     security_groups = [aws_security_group.eks_sg.id]
     from_port = 2049
     to_port = 2049 
     protocol = "tcp"
   }     
        
   egress {
     security_groups = [aws_security_group.eks_sg.id]
     from_port = 0
     to_port = 0
     protocol = "-1"
   }
 }