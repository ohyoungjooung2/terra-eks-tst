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

#Example
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
