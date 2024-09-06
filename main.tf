provider "aws" {
    region = "us-west-1"
  
}#Write

#VPC
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "main-tf-vpc"
    }
}
#Subnet 1
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.main.id 
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-west-1a"

    tags = {
        Name = "Subnet1"
    }
 
}
resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-1c"

  tags = {
      Name = "Subnet2"
  }

}
#Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "main-igw"
    }
}
#Route Table
resource "aws_route_table" "aws_route_table" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
  tags = {
    Name = "Route Table"
  }
}
#Route Table Association Subnet 1
resource "aws_route_table_association" "subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.aws_route_table.id
}

#Route Table Association Subnet 1
resource "aws_route_table_association" "Subnet2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.aws_route_table.id
}