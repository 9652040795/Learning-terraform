#Creating an EC2 instance in Public Subnet must mention the "Subnet ID"#
resource "aws_instance" "cloudelligent" {
  ami = "ami-0761247d"
#   ami = "${var.ami-id}"
  instance_type = "t2.micro"
  subnet_id = "subnet-0b03fbea26eafeb61"
#  subnet_id = "${var.ec2-subnet}"
  count = "${length(var.azs)}"
  tags {
    Name= "cloudelligent-ec2-${count.index+1}"
  }
}