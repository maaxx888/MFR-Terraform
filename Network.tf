#create public subnet
resource "aws_subnet" "public-subnet-1" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/internal_elb" = 1
  }
}

#create second public subnet
resource "aws_subnet" "public-subnet-2" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/internal_elb" = 1
  }
}

#create private subnet
resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "private-subnet-1"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/internal_elb" = 1
  }
}

#create second private subnet
resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "private-subnet-2"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/internal_elb" = 1
  }
}

#create gateway
resource "aws_internet_gateway" "gateway-1" {
  vpc_id = aws_vpc.vpc-1.id
  tags = {
    Name = "gateway-1"
  }
}


#elastic ip
resource "aws_eip" "eip-1" {
  depends_on                = [aws_internet_gateway.gateway-1]
}

#elastic ip
resource "aws_eip" "eip-2" {
  depends_on                = [aws_internet_gateway.gateway-1]
}