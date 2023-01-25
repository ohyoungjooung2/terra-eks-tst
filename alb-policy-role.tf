#https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
resource "aws_iam_policy" "alb-role-policy" {
    policy = "${file("alb_iam_policy.json")}"
}


resource "aws_iam_role" "alb-role" {
    name = "AmazonEKSLoadBalancerControllerRole"
    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${aws_iam_openid_connect_provider.tst-eks.arn}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "${replace(aws_iam_openid_connect_provider.tst-eks.url, "https://", "")}:aud": "sts.amazonaws.com",
                    "${replace(aws_iam_openid_connect_provider.tst-eks.url, "https://", "")}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
                }
            }
        }
     ]
}
    POLICY

     depends_on = [
         aws_eks_node_group.tst-eks-node-grp,
     ]


  }


#attach alb policy to alb role
resource "aws_iam_role_policy_attachment" "attchAmazonalbPolicy"{
    role = aws_iam_role.alb-role.name
    policy_arn = aws_iam_policy.alb-role-policy.arn

}

#Add aws-load-balancer-controller-service-account
resource "null_resource" "alb-yml-execute" {
    provisioner "local-exec" {

     command = "aws eks update-kubeconfig --region ${var.aws_region}  --name ${var.cluster-name}"

    }

    depends_on = [
        aws_iam_role_policy_attachment.attchAmazonalbPolicy,
    ]
}


#Create service account
resource "null_resource" "crt-sa" {
   provisioner "local-exec" {
   command =  <<-EOF
             echo  "apiVersion: v1"   > aws-load-ban-sa.yaml
             echo  "kind: ServiceAccount"   >> aws-load-ban-sa.yaml
             echo  "metadata:"   >> aws-load-ban-sa.yaml
             echo  "  labels:"   >>aws-load-ban-sa.yaml
             echo  "    app.kubernetes.io/component: controller" >> aws-load-ban-sa.yaml
             echo  "    app.kubernetes.io/name: aws-load-balancer-controller"  >> aws-load-ban-sa.yaml
             echo  "  name: aws-load-balancer-controller" >> aws-load-ban-sa.yaml
             echo  "  namespace: kube-system"  >> aws-load-ban-sa.yaml
             echo  "  annotations:"  >> aws-load-ban-sa.yaml
             echo  "     eks.amazonaws.com/role-arn: ${aws_iam_role.alb-role.arn}"  >> aws-load-ban-sa.yaml

   EOF
   #interpreter = [ "/bin/bash","-c"]
   # When we must use windows' git-bash or something like that
   interpreter = [    "C:\\Program Files\\Git\\git-bash.exe", "-c" ]

   }

   triggers = {
    always_run = "${timestamp()}"
   }

   depends_on = [
    aws_iam_role_policy_attachment.attchAmazonalbPolicy,
   ]
}
resource "null_resource" "crt-sa-account" {
   provisioner "local-exec" {
   command =  "${var.home_dir}/bin/kubectl apply -f aws-load-ban-sa.yaml"
   interpreter = [    "C:\\Program Files\\Git\\git-bash.exe", "-c" ]

    }

   triggers = {
    always_run = "${timestamp()}"
   }

   depends_on = [
       null_resource.crt-sa, 
   ]
}