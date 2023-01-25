# #alb install from yaml, internet connection is necesaary...

# #Certmanager
# resource "null_resource" "apply-cert-manager"{
#     provisioner "local-exec" {
#         command = "kubectl apply --validate=false  -f https://github.com/jetstack/cert-manager/releases/download/v1.5.4/cert-manager.yaml; kubectl get po -n cert-manager"
#          interpreter = [
#            #"/usr/bin/bash","-c"
#              "C:\\Program Files\\Git\\git-bash.exe", "-c"
#          ]
#     }
#      triggers = {
#     always_run = "${timestamp()}"
#    }
#     depends_on = [
#         null_resource.crt-sa-account,
#     ]
# }

# resource "null_resource" "down-controller" {
#     provisioner "local-exec" {

#         command = <<-EOF
#                curl -Lo v2_4_4_full.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.4.4/v2_4_4_full.yaml;
#                echo $?
#                sed -i.bak -e '480,488d' ./v2_4_4_full.yaml
#                echo $?
#                sed -i.bak -e 's|your-cluster-name|${var.cluster-name}|' ./v2_4_4_full.yaml
#                echo "apply v2_4_4_full.yaml"
#             #    kubectl apply -f v2_4_4_full.yaml --validate=false
#                kubectl apply -f v2_4_4_full.yaml
#                echo "Download v2_4_4_ingclass.yaml"
#                curl -Lo v2_4_4_ingclass.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.4.4/v2_4_4_ingclass.yaml
#                echo "apply v2_4_4_ingclass.yaml"
#                kubectl apply -f v2_4_4_ingclass.yaml
#                echo -e "[0;31m Final check [0m"
#                kubectl get deployment -n kube-system aws-load-balancer-controller
#         EOF
#          interpreter = [
#           #  "/usr/bin/bash","-c"
#             "C:\\Program Files\\Git\\git-bash.exe", "-c"
#          ]
#     }
#    triggers = {
#     always_run = "${timestamp()}"
#    }

#     depends_on = [
#         null_resource.apply-cert-manager,
#     ]
# }