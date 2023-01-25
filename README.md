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
Aws authentication setup.(of course, aws account is a must.
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
