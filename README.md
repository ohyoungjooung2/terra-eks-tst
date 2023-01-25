#terra-eks-tst
```
This scripts provides set-up of EKS(Aws kubernetes).
Default region: ap-northeast-2(variables.tf).
terraform version: 

$ terraform.exe --version
Terraform v1.3.7
on windows_amd64


Shell: git-bash -> C:\\Program Files\\Git\\git-bash.exe", "-c

Linux nat instance instead of NAT, cause on development, nat instance enough and cheaper than AWS NAT SERVICE.


```

#Prerequsites
```
Aws authentication setup.(of course, aws account is a must)
$ aws --version
aws-cli/2.9.13 Python/3.9.11 Windows/10 exe/AMD64 prompt/off
#Check eks env.
$ aws eks list-clusters
{
    "clusters": []
}
Help: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html
      https://aws.amazon.com/free/?nc1=h_ls&all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all
           
$ which kubectl
/c/Users/ohyou/bin/kubectl

#Also kubectl is necessary to check eks cluster.
oyj@homeoyj MINGW64 ~/
$ kubectl.exe version
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"26", GitVersion:"v1.26.0", GitCommit:"b46a3f887ca979b1a5d14fd39cb1af43e7e5d12d", GitTreeState:"clean", BuildDate:"2022-12-08T19:58:30Z", GoVersion:"go1.19.4", Compiler:"gc", Platform:"windows/amd64"}
Kustomize Version: v4.5.7

```

#Variables
```
To create a instance, (we) need a ssh key thas is located in the $HOME(%HOME%-windows) directory.
#Git bash example(it is same as windows %HOME%)
$ echo $HOME
/c/Users/ohyou

*You might have to change variable.tf. For example, if we want to add other clusters on the same vpc network, then change the cluster-name eithger by edit variable.tf or add command line option like "terraform plan -var "cluster-name=wanted-name" and "terraform apply"
For example,addons, aws region, eks cluster name, addons list.

```

#Example-terraform init(initialize)
```
oyj@homeoyj MINGW64 ~
$ mkdir aws-eks-terraform

oyj@homeoyj MINGW64 ~
$ cd aws-eks-terraform/

oyj@homeoyj MINGW64 ~/aws-eks-terraform
$ git clone git@github.com:ohyoungjooung2/terra-eks-tst.git
Cloning into 'terra-eks-tst'...
remote: Enumerating objects: 176, done.
remote: Counting objects: 100% (176/176), done.
remote: Compressing objects: 100% (141/141), done.
remote: Total 176 (delta 22), reused 157 (delta 12), pack-reused 0
Receiving objects: 100% (176/176), 1.67 MiB | 1.02 MiB/s, done.
Resolving deltas: 100% (22/22), done.


oyj@homeoyj MINGW64 ~/aws-eks-terraform
$ cd terra-eks-tst/

oyj@homeoyj MINGW64 ~/aws-eks-terraform/terra-eks-tst (main)
$ terraform.exe init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/null...
- Finding latest version of hashicorp/tls...
- Finding latest version of hashicorp/http...
- Finding hashicorp/aws versions matching "~> 3.72"...
- Installing hashicorp/tls v4.0.4...
- Installed hashicorp/tls v4.0.4 (signed by HashiCorp)
- Installing hashicorp/http v3.2.1...
- Installed hashicorp/http v3.2.1 (signed by HashiCorp)
- Installing hashicorp/aws v3.76.1...
- Installed hashicorp/aws v3.76.1 (signed by HashiCorp)
- Installing hashicorp/null v3.2.1...
- Installed hashicorp/null v3.2.1 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

```

#Examples terraform plan 

```
$ terraform.exe plan -var "home_dir=c:\Users\ohyou"
 ...................
 # aws_vpc.dev-vpc will be created
  + resource "aws_vpc" "dev-vpc" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.0.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_classiclink                   = (known after apply)
      + enable_classiclink_dns_support       = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name"                                     = "terraform-dev-node"
          + "kubernetes.io/cluster/{var.cluster-name}" = "owned"
        }
      + tags_all                             = {
          + "Name"                                     = "terraform-dev-node"
          + "kubernetes.io/cluster/{var.cluster-name}" = "owned"
        }
    }

  # null_resource.alb-yml-execute will be created
  + resource "null_resource" "alb-yml-execute" {
      + id = (known after apply)

```

#Examples terraform apply

```
$ terraform.exe apply  -var "home_dir=c:\Users\ohyou"
.....other output is cut out cause it is too long.....
Changes to Outputs:
  + endpoint                              = (known after apply)
  + instance_ip_addr                      = (known after apply)
  + kubeconfig-certificate-authority-data = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


aws_iam_policy.alb-role-policy: Creating...
aws_key_pair.dev_pub: Creating...
aws_cloudwatch_log_group.tst-eks: Creating...
aws_iam_role.tst-eks: Creating...
aws_iam_role.tst-eks-iam-for-node: Creating...
aws_vpc.dev-vpc: Creating...
aws_cloudwatch_log_group.tst-eks: Creation complete after 0s [
......

null_resource.crt-sa-account: Creating...
null_resource.crt-sa-account: Provisioning with 'local-exec'...
null_resource.crt-sa-account (local-exec): Executing: ["C:\\Program Files\\Git\\git-bash.exe" "-c" "c:\\Users\\ohyou/bin/kubectl apply -f aws-load-ban-sa.yaml"]
null_resource.crt-sa-account: Creation complete after 0s [id=6412554255157381358]
null_resource.alb-yml-execute (local-exec): Updated context arn:aws:eks:ap-northeast-2:494307375889:cluster/tst-eks in C:\Users\ohyou\.kube\config
null_resource.alb-yml-execute: Creation complete after 1s [id=4458723972934890591]
aws_eks_addon.tst-eks-addon["coredns"]: Creation complete after 8s [id=tst-eks:coredns]
aws_eks_addon.tst-eks-addon["vpc-cni"]: Still creating... [10s elapsed]
aws_eks_addon.tst-eks-addon["vpc-cni"]: Still creating... [20s elapsed]
aws_eks_addon.tst-eks-addon["vpc-cni"]: Still creating... [30s elapsed]
aws_eks_addon.tst-eks-addon["vpc-cni"]: Still creating... [40s elapsed]
aws_eks_addon.tst-eks-addon["vpc-cni"]: Still creating... [50s elapsed]
aws_eks_addon.tst-eks-addon["vpc-cni"]: Still creating... [1m0s elapsed]
aws_eks_addon.tst-eks-addon["vpc-cni"]: Creation complete after 1m6s [id=tst-eks:vpc-cni]

Apply complete! Resources: 36 added, 0 changed, 0 destroyed.

Outputs:

endpoint = "https://E1F3FE780F1212A8C2178575023B7C83.gr7.ap-northeast-2.eks.amazonaws.com"
instance_ip_addr = "43.200.254.156"
kubeconfig-certificate-authority-data = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMvakNDQWVhZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJek1ERXlOVEE0TVRJeE1Wb1hEVE16TURFeU1qQTRNVEl4TVZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBT1hsCnoxYnhlNVorT1k5N0R2N3pLUE5DNHNDb3J5WHhZWW9Zc2pqUUxKVFpCeVZCK0tNWUZ0RnZneEg0Rzg5QWpZUGMKdi9RVlZaSnRvcFpKYytuZ1N0YTlBSllOdWkwTERlVDRhOHJKZFVPb1AwdHZFcnVqckhoZWNTdndqcDlZTEtiZQpDRFJRM0FreVA4akJ4UVljZkFFQ0RaRHBCZDFmdFVkNzVrYnZRcU1Lc0c1N3ZNeWFxRXdpbzlxdVZPUzRDRGlnCkRjMThFMnVubk5oRUZkYnMxOXpsdnBOTmNTTmhBNFJMQmdCMi9kUjlRT2JEdnhXVWp6WWhVKy9CSklxRUhDTmwKWE04WlluWkZPbnl4ZTdvSUNueUpFOTM0b0xDS0RYZ090Z2owNGVuZkFObzd4QVBsSkZ0UUxXNFZoV0FkOGpIYwpRSlliQ2l0ZEZJNTN5YUR0RE5VQ0F3RUFBYU5aTUZjd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZGaEpkNk5pM0tnR1NRR0FjTGYzblIxdDA5eWpNQlVHQTFVZEVRUU8KTUF5Q0NtdDFZbVZ5Ym1WMFpYTXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSjVoTzhmSDFxc2I1WnBDbThNUwpqR0RjUDVYeTlTb0JZZnlDeUl0ZmRpbnpPcFFrTEtYbG5xNm9QRjhjTXlGOEczUW8vemlScm5WSUFERU5uMUY5CjNiZGZFUloxOVNPOG5sYU9mUHlpTkQwSThDOWhKUW9ycGtoUmZwWWlxc08yTGJiclhJcnNUek5OakhqeStnR2YKQjhhZVBMTjlMZmhTT2x1V2RMM1AyZDZpZDdtZUJ4REZnQlo0REQ5ZFQ3OGZyZmk2OGo3U1lwWXNhelhZakd6awpwTmRqR3RKY1RSUDBKWlJIbjV2Z1NEdkR6NE1STzZWUERVRWwxSlhqT29naDRrSWt1S2Z0TXVvdVF2czBRVG9DCjhOeW55a1UzNlFrbGVmRWlvSW9ZbTJ2VmpBTkZqUVB5bVp3Y0M1dDgzckQ2S2JPQ24vckowNURBNGl3M294UlkKUmJZPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="

#To confirm.(Only two node is enough for dev I suppose, but somtimes need more nodes..:))
$ kubectl.exe get no -o wide
NAME                                            STATUS   ROLES    AGE     VERSION               INTERNAL-IP   EXTERNAL-IP   OS-IMAGE         KERNEL-VERSION                 CONTAINER-RUNTIME
ip-10-0-2-213.ap-northeast-2.compute.internal   Ready    <none>   5m30s   v1.24.7-eks-fb459a0   10.0.2.213    <none>        Amazon Linux 2   5.4.226-129.415.amzn2.x86_64   containerd://1.6.6
ip-10-0-3-88.ap-northeast-2.compute.internal    Ready    <none>   5m35s   v1.24.7-eks-fb459a0   10.0.3.88     <none>        Amazon Linux 2   5.4.226-129.415.amzn2.x86_64   containerd://1.6.6

$ kubectl.exe get po -n kube-system
NAME                      READY   STATUS    RESTARTS   AGE
aws-node-622nb            1/1     Running   0          5m21s
aws-node-82wmk            1/1     Running   0          5m45s
coredns-dc4979556-46zv6   1/1     Running   0          11m
coredns-dc4979556-ndg2t   1/1     Running   0          11m
kube-proxy-rc4p5          1/1     Running   0          6m34s
kube-proxy-z5lbm          1/1     Running   0          6m29s

...
And it is OK...:) to apply pod and etc.

$ kubectl apply -f https://k8s.io/examples/application/deployment-scale.yaml
deployment.apps/nginx-deployment created

$ kubectl.exe get po
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-66b957f9d-295f5   1/1     Running   0          33s
nginx-deployment-66b957f9d-7t896   1/1     Running   0          33s
nginx-deployment-66b957f9d-gssfp   1/1     Running   0          33s
nginx-deployment-66b957f9d-rhvb8   1/1     Running   0          33s

$ kubectl.exe port-forward nginx-deployment-66b957f9d-rhvb8 3333:80
Forwarding from 127.0.0.1:3333 -> 80
Forwarding from [::1]:3333 -> 80

#From other terminal
$ curl http://localhost:3333
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   612  100   612    0     0  12768      0 --:--:-- --:--:-- --:--:-- 13021<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>


```


*Good Luck*
