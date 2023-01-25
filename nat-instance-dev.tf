#Aws key generate
resource "aws_key_pair" "dev_pub" {
  key_name = "dev_pub"
  #public_key = file("/home/oyj/.ssh/id_rsa.pub")
  public_key = file("${var.home_dir}/.ssh/id_rsa.pub")
}

resource "aws_instance" "nat" {
  ami                         = "${lookup(var.aws_dev_pub_ami, var.aws_region)}"
  instance_type               = "t2.micro"
  key_name                    = "dev_pub"
  vpc_security_group_ids      = ["${aws_security_group.eks_sg.id}"]
  subnet_id                   = "${aws_subnet.pub.id}"
  associate_public_ip_address = true
  source_dest_check           = false
}

#For test we need public ip. Sometimes just vpn provided private ip? or if we can connect with private ip
output "instance_ip_addr" {
  value = aws_instance.nat.public_ip
  #value = aws_instance.dev_pub_ami.private_ip
}
#  resource "aws_route_table_association" "rt-association-pub" {
#    subnet_id      = "${aws_subnet.pub.id}"
#    route_table_id = "${aws_route_table.dev-nat-rt.id}"
#  }
# resource "aws_route_table_association" "rt-association1" {
#   subnet_id      = "${aws_subnet.tst-eks1.id}"
#   route_table_id = "${aws_route_table.dev-pub-rt.id}"
# }
# resource "aws_route_table_association" "rt-association2" {
#   subnet_id      = "${aws_subnet.tst-eks2.id}"
#   route_table_id = "${aws_route_table.dev-pub-rt.id}"
# }


  #user_data = "${file("nat-user-data.yml")}"

#  provisioner "local-exec" {
#     #CrossOrigin need to be changed in aws ip(private or public,depends on environment)
#     #command = "echo ${aws_instance.dev_pub_ami.public_ip} >> private_ips.txt"
#     command = "sed -i '25 s/^.*$/@CrossOrigin(origins = \"http:\\/\\/${aws_instance.dev_pub_ami.public_ip}\")/g' ./vue-spboot-mysl/src/main/java/com/spvue/ex/controller/CustomerController.java; cd ./vue-spboot-mysl; ./mvnw clean;./mvnw install"
#   }

#  provisioner "local-exec" {
#    command = "sed -i '6 s/^.*$/baseURL: \"http:\\/\\/${aws_instance.dev_pub_ami.public_ip}:8080\\/api\",/g' ./vue-spboot-mysl/frontend/src/http-common.js; cd ./vue-spboot-mysl/frontend/; rm -f ./dist.tar.xz; rm -rf ./dist;npm install; npm run build; tar cvJf dist.tar.xz dist"
#    #baseURL: "http://localhost:8080/api", vue-spboot-mysl/frontend/src/http-common.js
#  }

#   provisioner "file" {
#     source = "./vue-spboot-mysl/frontend/dist.tar.xz"
#     destination = "/home/ec2-user/dist.tar.xz"
#   }

#   connection {
#     type = "ssh"
#     user = "ec2-user"
#     private_key = file("~/.ssh/id_rsa")
#     host = self.public_ip
#   }
  
#   provisioner "file" {
#     source = "mysql_auth.sh"
#     destination = "/tmp/mysql_auth.sh"
#   }

#   provisioner "file" {
#     source = "amzon-node-inst.sh"
#     destination = "/tmp/amzon-node-inst.sh"
#   }

#   provisioner "file" {
#     source = "./vue-spboot-mysl/target/vue-spboot-mysl-0.0.1-SNAPSHOT.jar"
#     destination = "/home/ec2-user/vue-spboot-mysl-0.0.1-SNAPSHOT.jar"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo yum -y update",
#       "sudo yum -y install java-1.8.0-openjdk.x86_64",
#       "bash /tmp/amzon-node-inst.sh",
#       "sudo yum -y install httpd",
#       "cd /home/ec2-user;tar xvJf dist.tar.xz;sudo cp -rfpv dist/* /var/www/html/",
#       "sudo yum -y install mysql",
#       #"sudo yum -y install tomcat8 tomcat8-webapps.noarch",
#       "sudo yum -y install mariadb-server",
#       "sudo systemctl enable mariadb",
#       "sudo systemctl start mariadb",
#       "chmod +x /tmp/mysql_auth.sh",
#       "bash /tmp/mysql_auth.sh",
#       #For production service but dev also need?
#       "sudo chmod 700 /home/ec2-user/vue-spboot-mysl-0.0.1-SNAPSHOT.jar",
#       "sudo ln -s /home/ec2-user/vue-spboot-mysl-0.0.1-SNAPSHOT.jar /etc/init.d/vsm",
#       "sudo chkconfig --add vsm",
#       "sudo chkconfig --level 234 vsm on",
#       "sudo service vsm start",
#       "sudo service httpd start",
#     ]

#   }

#   tags = {
#     Name = "dev_pub_instance"
#   }
   
# }
