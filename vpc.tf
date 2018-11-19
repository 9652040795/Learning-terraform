provider "aws" {
  region = "${var.region}"
}
resource "aws_vpc" "my-vpc" {
  cidr_block = "${var.vpc-cidr}"
  instance_tenancy = "default"
  enable_dns_support = "true"
  tags {
    Name= "Cloudelligent-VPC"
    Location= "Viginia"
  }
}



#resource "aws_subnet" "public-subnets" {
#  availability_zone = "${element(var.azs,count.index)}"

#  count = "${length(var.azs)}"
#  cidr_block = "${element(var.vpc-public-subnet-cidr,count.index)}"
#  vpc_id = "${aws_vpc.my-vpc.id}"
#  map_public_ip_on_launch = "true"

#  tags {
#    Name = "Public-Subnet-${count.index+1}"
#    Location = "Viginia"
#  }
#}

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

#CREATING PUBLIC SUBNET 1
resource "aws_subnet" "public-subnet-1" {
  cidr_block = "${var.vpc-public-subnet-1}"
  vpc_id = "${aws_vpc.my-vpc.id}"

  tags {
    Name = "Public-Subnet-1"
  }
}

#CREATING PUBLIC SUBNET 2
resource "aws_subnet" "public-subnet-2" {
  cidr_block = "${var.vpc-public-subnet-2}"
  vpc_id = "${aws_vpc.my-vpc.id}"

  tags {
    Name = "Public-Subnet-2"
  }
}

#CREATING PUBLIC SUBNET 3
resource "aws_subnet" "public-subnet-3" {
  vpc_id = "${aws_vpc.my-vpc.id}"
  cidr_block = "${var.vpc-public-subnet-3}"

  tags {
    Name = "Public-Subnet-3"
  }
}

#CREATING PRIVATE SUBNETS FROM A LIST

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
      Name= "Cloudelligent-Internet-Gate-Way"

  }
}


#CREATING A PUBLIC ROUTE-TABLE FOR PUBLIC-SUBNET-1
    resource "aws_route_table" "public-route-1" {
      vpc_id = "${aws_vpc.my-vpc.id}"
      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
      }
      tags {
        Name = "Public-Subnet-Route-1"
      }
    }

#CREATING A PUBLIC ROUTE-TABLE FOR PUBLIC-SUBNET-2
resource "aws_route_table" "public-route-2" {
  vpc_id = "${aws_vpc.my-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "Public-Subnet-Route-2"
  }
}

#CREATING A PUBLIC ROUTE-TABLE FOR PUBLIC-SUBNET-3
resource "aws_route_table" "public-route-3" {
  vpc_id = "${aws_vpc.my-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "Public-Subnet-Route-3"
  }
}

#ASSOCIATE/LINK PUBLIC-ROUTE WITH PUBLIC-SUBNET-1
resource "aws_route_table_association" "public-route-1" {
  route_table_id = "${aws_route_table.public-route-1.id}"
  subnet_id = "${aws_subnet.public-subnet-1.id}"
}

#ASSOCIATE/LINK PUBLIC-ROUTE WITH PUBLIC-SUBNET-2
resource "aws_route_table_association" "public-route-2" {
  route_table_id = "${aws_route_table.public-route-2.id}"
  subnet_id = "${aws_subnet.public-subnet-2.id}"
}

#ASSOCIATE/LINK PUBLIC-ROUTE WITH PUBLIC-SUBNET-3
resource "aws_route_table_association" "public-route-3" {
  route_table_id = "${aws_route_table.public-route-3.id}"
  subnet_id = "${aws_subnet.public-subnet-3.id}"
}



#ASSOCIATE/LINK PUBLIC-ROUTE WITH PUBLIC-SUBNETS
# https://github.com/hashicorp/terraform/issues/14880
#resource "aws_route_table_association" "public-route" {
#  count = "${length(var.azs)}"
#  route_table_id = "${aws_route_table.public-route.id}"
#  subnet_id = "${element(aws_subnet.public-subnets.*.id, count.index)}"
#}


#ElASTIC IP FOR NAT GATWAY-1
#resource "aws_eip" "nat-eip-1" {
#  vpc = "true"
#  depends_on = ["aws_internet_gateway.igw"]
#}

#NAT-GATEWAY FOR PRIVATE IP ADDRESSES
#resource "aws_nat_gateway" "ngw" {
#  allocation_id = "${aws_eip.nat-eip-1.id}"
#  subnet_id = ""
#}







#OUTPUT OF PUBLIC-SUBNETS-IDS

output "public-subnet-1-id" {
  value = "${aws_subnet.public-subnet-1.id}"
}

output "public-subnet-2-id" {
  value = "${aws_subnet.public-subnet-2.id}"
}

output "public-subnet-3-id" {
  value = "${aws_subnet.public-subnet-3.id}"
}

#OUTPUT OF PRIVATE-SUBNETS-IDS

output "priavte-subnet-ids" {
  value = "${aws_subnet.private-subnets.*.id}"
}