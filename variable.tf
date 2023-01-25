data "aws_caller_identity" "current" {}

# variable "account_id" {
#   default = data.aws_caller_identity.account_id
# }

#Where ssh key is located. (ex. $HOME/.ssh or.... terraform plan(apply)  -var "home_dir=directory")
variable "home_dir"{
  default = ""
}

variable "aws_region" {
  default = "ap-northeast-2"
  type    = string
}

variable "cluster-name"{
  default = "tst-eks"
}

variable "cluster-version"{
  default = 1.24
}

variable "aws_dev_pub_ami" {
  default = {
    #ap-northeast-2 = "ami-05a4cce8936a89f06"
    #ap-northeast-2 = "ami-0d777f54156eae7d9"
    #ap-northeast-2 = "ami-08ffef921295fd55c"
    #ap-northeast-2 = "ami-0bd7691bf6470fe9c"
    ap-northeast-2 = "ami-0a7f5342e82d8ae53"
  }
}

variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))

  default = [
    {
      name    = "kube-proxy"
      #1.23
      # version = "v1.23.8-eksbuild.2"
      #version = "v1.22.6-eksbuild.1"
      #defualt(debian-based)-1.24
      #1.24
      version = "v1.24.7-eksbuild.2"
      #Minimal type 
      # version = "v1.24.7-eksbuild.1"
    },
    {
      name    = "vpc-cni"
      #1.23
      version = "v1.12.0-eksbuild.1"
      #version = "v1.11.2-eksbuild.1"
      #1.24
      # version = "v1.12.0-eksbuild.2"
    },
     {
       name    = "coredns"
       #1.23 need at leastn .2
       #version = "v1.8.7-eksbuild.2"
       #1.24 need at least .3
       version = "v1.8.7-eksbuild.3"
       #version = "v1.8.7-eksbuild.3"
     },
    #  {
    #    name    = "aws-ebs-csi-driver"
    #    #version = "v1.10.0-eksbuild.1"
    #    version = "v1.14.0-eksbuild.1"
    #  },
  ]
}