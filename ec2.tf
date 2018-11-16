#Creating an EC2 instance in Public Subnet must mention the "Subnet ID"#
resource "aws_instance" "cloudelligent" {
  ami = "ami-0761247d"
  instance_type = "t2.micro"
  subnet_id = "subnet-0b03fbea26eafeb61"
  count = "3"
  tags {
    Name= "cloudelligent-ec2-${count.index+1}"
  }
}