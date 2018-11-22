#Creating an EC2 instance in Public Subnet must mention the "Subnet ID"#
resource "aws_instance" "cloudelligent" {
  ami = "ami-0ac019f4fcb7cb7e6"
#   ami = "${var.ami-id}"
  instance_type = "t2.micro"
#  subnet_id = "subnet-0b03fbea26eafeb61"
#  subnet_id = "${var.ec2-subnet}"
  count = "3"
  subnet_id = "${element(var.ec2-subnets-id,count.index)}"
  tags {
    Name= "cloudelligent-ec2-${count.index+1}"
  }
}