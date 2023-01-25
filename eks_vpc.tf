resource "aws_vpc" "dev-vpc" {
      cidr_block = "10.0.0.0/16"
      enable_dns_hostnames = true
      tags = "${
        tomap(
        {"Name"= "terraform-dev-node",
        "kubernetes.io/cluster/{var.cluster-name}"= "owned",
      })
      }"
}

#Priv subnt(for pub elb)
resource "aws_subnet" "tst-eks1" {
      availability_zone = "ap-northeast-2a"
      cidr_block = "10.0.2.0/24"
      vpc_id = "${aws_vpc.dev-vpc.id}"
      tags = "${
         tomap({
         "Name"="terraform-dev-eks-subnet-pri1",
         #"kubernetes.io/role/internal-elb"="1",
         "kubernetes.io/role/elb"="1",
         "kubernetes.io/cluster/${var.cluster-name}"="owned",
      })
      }"
}

#priv subnet2(for pub elb)
resource "aws_subnet" "tst-eks2" {
      availability_zone = "ap-northeast-2c"
      cidr_block = "10.0.3.0/24"
      vpc_id = "${aws_vpc.dev-vpc.id}"
      tags = "${
         tomap(
         {"Name"="terraform-dev-eks-subnet-pri2",
         "kubernetes.io/cluster/${var.cluster-name}"="owned",
         "kubernetes.io/role/elb"="1",
         #"kubernetes.io/role/internal-elb"="1",
      })
      }"
}

resource "aws_subnet" "pub" {
      availability_zone = "ap-northeast-2a"
      cidr_block = "10.0.4.0/24"
      vpc_id = "${aws_vpc.dev-vpc.id}"
      map_public_ip_on_launch = true
      tags = "${
         tomap(
         {"Name"="terraform-dev-eks-subnet-pub",
      })
      }"
}


resource "aws_internet_gateway" "dev-gw" {
  vpc_id = "${aws_vpc.dev-vpc.id}"
  tags = {
    Name = "terraform-dev-gw"
  }
}

#Default vpc routing
resource "aws_default_route_table" "default-vpc-rt" {
      default_route_table_id = aws_vpc.dev-vpc.default_route_table_id
      route{
            #cidr_block = "172.0.0.0/16"
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.dev-gw.id
      }

      tags = {
            Name = "default_vpc_route_table"
      }
}

resource "aws_route_table" "dev-nat-rt" {
  vpc_id = "${aws_vpc.dev-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}

resource "aws_route_table" "internet-gw-route" {
      vpc_id = "${aws_vpc.dev-vpc.id}"
      route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.dev-gw.id
      }

      tags = {
            "Name" = "dev-gw-route-table"
      }
}

 resource "aws_route_table_association" "tst-eks-rt-association1" {
       subnet_id = "${aws_subnet.tst-eks1.id}"
       route_table_id = "${aws_route_table.dev-nat-rt.id}"
 }

 resource "aws_route_table_association" "tst-eks-rt-association2" {
       subnet_id = "${aws_subnet.tst-eks2.id}"
       route_table_id = "${aws_route_table.dev-nat-rt.id}"
 }

# resource "aws_route_table_association" "rt-association-default-vpc" {
#    default_route_table_id = aws_vpc.dev-vpc.default_route_table_id
#    route_table_id = "${aws_route_table.internet-gw-route.id}"
#    tags = {
#       Name = "rt-associate-default-vpc-route-table-internet-gw"
#    }
# }


# resource "aws_vpc_endpoint_route_table_association" "tst-eks-vpc-rt-assoic" {
#   route_table_id  = aws_route_table.tst-eks-rt.id
#   #vpc_endpoint_id = aws_vpc_endpoint.example.id
#   vpc_endpoint_id = "vpce-095c322643655f714"
# }

#
##Route associate nat instance to private subnet2
#resource "aws_route_table_association" "dev-rt-natinst-association2" {
#      subnet_id = "${aws_subnet.dev-node-subnet-pri2.id}"
#      route_table_id = "${aws_route_table.dev-rt-nat.id}"
#}
#
#
##Route associate nat instance to private subnet1
#resource "aws_route_table_association" "dev-rt-natinst-association1" {
#      subnet_id = "${aws_subnet.dev-node-subnet-pri1.id}"
#      route_table_id = "${aws_route_table.dev-rt-nat.id}"
#}
#