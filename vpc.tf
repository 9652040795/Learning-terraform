provider "aws" {
  region = "${var.region}"
}
resource "aws_vpc" "my-vpc" {
  cidr_block = "${var.vpc-cidr}"
  instance_tenancy = "default"
  enable_dns_support = "true"
  tags {
    Name= "my-vpc"
    Location= "Viginia"
  }
}



resource "aws_subnet" "public-subnets" {
  availability_zone = "${element(var.azs,count.index)}"

  count = "${length(var.azs)}"
  cidr_block = "${element(var.vpc-public-subnet-cidr,count.index)}"
  vpc_id = "${aws_vpc.my-vpc.id}"
  map_public_ip_on_launch = "true"

  tags {
    Name = "Public-Subnet-${count.index+1}"
    Location = "Viginia"
  }
}

#In Case of fetching all AZ from a Region.
##############################################################
#resource "aws_subnet" "public-subnet" {
#  availability_zone = "${element(data.aws_availability_zones.azs.names,count.index)}"
#  count = "${length(data.aws_availability_zones.azs.names)}"
#  cidr_block = "${element(var.public_subnets,count.index)}"
#  vpc_id = "${aws_vpc.my-vpc.id}"
#  map_public_ip_on_launch = "true"
#  tags {
#    Name= "Public-subnet-${count.index+1}" #for dynamic names eg. Public-subnet-1
#  }



resource "aws_subnet" "private-subnets" {
  availability_zone = "${element(var.azs,count.index)}"

  count = "${length(var.azs)}"
  cidr_block = "${element(var.vpc-private-subnet-cidr,count.index)}"
  vpc_id = "${aws_vpc.my-vpc.id}"


  tags {
    Name = "Private-Subnet-${count.index+1}"
    Location = "Viginia"
  }
}


#CREATING A INTERNET GATEWAY

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.my-vpc.id}"

  tags {
      Name= "Internet-Gate-Way"

  }
}


#CREATING A PUBLIC ROUTE-TABLE FOR PUBLIC-SUBNET
    resource "aws_route_table" "public-route" {
      vpc_id = "${aws_vpc.my-vpc.id}"
      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
      }
      tags {
        Name = "Public-Subnet-Route"
      }
    }

#ASSOCIATE/LINK PUBLIC-ROUTE WITH PUBLIC-SUBNET
# https://github.com/hashicorp/terraform/issues/14880
resource "aws_route_table_association" "public-route" {
  count = "${length(var.azs)}"
  route_table_id = "${aws_route_table.public-route.id}"
  subnet_id = "${element(aws_subnet.public-subnets.*.id, count.index)}"
}



#OUTPUT OF PUBLIC-SUBNETS-IDS

output "public-subnet-ids" {
  value = "${aws_subnet.public-subnets.*.id}"
}

#OUTPUT OF PRIVATE-SUBNETS-IDS

output "priavte-subnet-ids" {
  value = "${aws_subnet.private-subnets.*.id}"
}