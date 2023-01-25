#Myip check to add sg group
data "http" "myip" {
  #url = "http://checkip.amazonaws.com"
  url = "http://ipv4.icanhazip.com"
   request_headers = {
    Accept = "application/json"
    #Accept = "Content-Type: text/plain; charset=utf-8"
  }
}

resource "aws_security_group" "eks_node_sg"{
  name = "eks_node_sg"
  description = "sg group all worker node craete using aws_eks_node_group instance"
  vpc_id      = "${aws_vpc.dev-vpc.id}"
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["10.0.4.0/24"]
    self        = true
 }
}

resource "aws_security_group" "eks_sg" {
  name        = "terraform_dev_pub_sg"
  description = "Security group for all worker nodes in pub 1 sbnet"
  vpc_id      = "${aws_vpc.dev-vpc.id}"
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    #Below deprecated
    # cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    self        = true
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    #Below deprecated
    #cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    self        = true
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    #Below deprecated
    #cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    self        = true
  }
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    self        = true
  }
  #  egress {
  #    security_groups = [aws_security_group.eks-efs-sg.id]
  #    from_port = 2049
  #    to_port = 2049 
  #    protocol = "tcp"
  #  }     
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }


  egress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }

  #To db rds subnet
  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    #cidr_blocks = ["10.3.2.0/24", "10.3.3.0/24"]
    self        = true
  }
  #Mysql self allow(only)
  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    self        = true
  }

  tags = "${
    tomap({
      "Name" = "terraform-dev-pub-node",
  })
  }"
}
