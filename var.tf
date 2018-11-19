#VPC Region
variable "region" {
  default = "us-east-1"
}

#VPC CIDR BLOCK
variable "vpc-cidr" {
  default = "192.168.0.0/16"
}

#VPC PUBLIC SUBNETS CIDR BLOCK
variable "vpc-public-subnet-cidr" {
  type = "list"
  default = ["192.168.1.0/24","192.168.2.0/24","192.168.3.0/24"]
}

#VPC PRIVATE SUBNETS CIDR BLOCK
variable "vpc-private-subnet-cidr" {
  type = "list"
  default = ["192.168.4.0/24","192.168.5.0/24","192.168.6.0/24"]
}




#CREATE MULTIPLE AZS or USE DATA SOURCES
#variable "azs" {
#  type = "list"
#  default = ["us-east-1a","us-east-1b","us-east-1c"]
#}

# Declare DATA SOURCE to get automatically fetch a AZS list from a Region.
#Simple just change the region from the top, all AZS in that region will be picked.
#data "aws_availability_zones" "azs" {}

#EC2 Setup Interactive
#variable "ami-id" {}
#variable "ec2-subnet" {}

#EC2 Subnet ID's for Subnets
variable "ec2-subnets-id" {
  type = "list"
  default = ["subnet-0b81a7528afbe2da0","subnet-027c42400b62a3a8b","subnet-0b3964e3fcafc5055"]
}