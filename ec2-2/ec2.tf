#Creating an EC2 instance in Public Subnet must mention the "Subnet ID"#
resource "aws_instance" "cloudelligent" {
  ami = "ami-8e8f2fe1"
#   ami = "${var.ami-id}"
  instance_type = "t2.micro"

#  Single Subnet
#  subnet_id = "subnet-0b03fbea26eafeb61"
#  subnet_id = "${var.ec2-subnet}"

# Number of EC2-instances required.
  count = "2"

  #EXISTING KEY PAIR OR CREATE ssh-keygen -f demo #it will give private & public keys, import public in aws
  #key_name = "power"

# EXPORTED PUBLIC-KEY
  key_name = "${aws_key_pair.power.key_name}"

# BASH SCRIPT
  user_data = "${file("httpd.sh")}"

# MULTIPLE SUBNETS IDS
  subnet_id = "${element(var.ec2-subnets-id,count.index)}"
  vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
  tags {
    Name= "open-swan-vpn-${count.index+1}"
  }
}

#EXPORTING OUR PUBLIC-KEY
resource "aws_key_pair" "power" {
  public_key = "${file("power.pub")}"
}