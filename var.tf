#VPC Region
variable "region" {
  default = "us-east-1"
}

#VPC CIDR BLOCK
variable "vpc-cidr" {
  default = "192.168.0.0/16"
}

#VPC PUBLIC SUBNETS CIDR BLOCK LIST
variable "vpc-public-subnet-cidr" {
  type = "list"
  default = ["192.168.1.0/24","192.168.2.0/24","192.168.3.0/24"]
}

# VPC PUBLIC SUBNET 1

#variable "vpc-public-subnet-1" {
#  default = "192.168.1.0/24"
#}
#variable "vpc-public-subnet-1-az" {
#  default = "us-east-1a"
#}

# VPC PUBLIC SUBNET 2
#variable "vpc-public-subnet-2" {
#  default = "192.168.2.0/24"
#}
#variable "vpc-public-subnet-2-az" {
#  default = "us-east-1b"
#}

# VPC PUBLIC SUBNET 3
#variable "vpc-public-subnet-3" {
#  default = "192.168.3.0/24"
#}
#variable "vpc-public-subnet-3-az" {
#  default = "us-east-1c"
#}


#VPC PRIVATE SUBNETS CIDR BLOCK LIST
variable "vpc-private-subnet-cidr" {
  type = "list"
  default = ["192.168.4.0/24","192.168.5.0/24","192.168.6.0/24"]
}

# VPC PRIVATE SUBNET 1
#variable "vpc-private-subnet-1" {
#  default = "192.168.4.0/24"
#}
#variable "vpc-priavte-subnet-1-az" {
#  default = "us-east-1a"
#}

# VPC PRIVATE SUBNET 2

#variable "vpc-private-subnet-2" {
#  default = "192.168.5.0/24"
#}
#variable "vpc-priavte-subnet-2-az" {
 # default = "us-east-1b"
#}

# VPC PRIVATE SUBNET 3

#variable "vpc-private-subnet-3" {
#  default = "192.168.6.0/24"
#}
#variable "vpc-priavte-subnet-3-az" {
#  default = "us-east-1c"
#}



#CREATE MULTIPLE AZS LIST
variable "azs" {
  type = "list"
  default = ["us-east-1a","us-east-1b","us-east-1c"]
}

# Declare DATA SOURCE to get automatically fetch a AZS list from a Region.
#Simple just change the region from the top, all AZS in that region will be picked.
#data "aws_availability_zones" "azs" {}
#########################################################################3
#EC2 Setup Interactive
#variable "ami-id" {}
#variable "ec2-subnet" {}

#######################################################################
#EC2 VARIABLES
#EC2 Subnet ID's for Subnets
variable "ec2-subnets-id" {
  type = "list"
  default = ["subnet-0f82144ac988d09f0","subnet-0110e2f5660653648","subnet-09e16122a2066bbff"]
}


##############################################################
#RDS VARIABLES
variable "rds_cidr" {
  default = "192.168.0.0/16"
}
variable "db_instance_class" {
  default = "db.t2.micro"
}
variable "rds_engine" {
  default = "mysql"
}
variable "engine_version" {
  default = "5.7.17"
}
variable "backup_retension_period" {
  default = "0"
}
variable "publicly_accessible" {
  default = "false"
}
variable "rds_username" {
  default = "sage"
}
variable "rds_password" {
  default = "cbaLpjjsihaha12"
}
variable "rds_allocated_storage" {
  default = "5"
}
variable "storage_type" {
  default = "gp2"
}
