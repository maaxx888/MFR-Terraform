#create routing table public
resource "aws_route_table" "routetb-1" {
  vpc_id = aws_vpc.vpc-1.id

  #ipv4
  route {
    cidr_block = "0.0.0.0/0" #send all trafic to here
    gateway_id = aws_internet_gateway.gateway-1.id
  }

  tags = {
    Name = "public-routetb-1"
  }
}

#create routing table private1
resource "aws_route_table" "private-routetb-1" {
  vpc_id = aws_vpc.vpc-1.id

  #ipv4
  route {
    cidr_block = "0.0.0.0/0" #send all trafic to here
    nat_gateway_id = aws_nat_gateway.nat-1.id
  }

  tags = {
    Name = "private-routetb-1"
  }
}

#create routing table private2
resource "aws_route_table" "private-routetb-2" {
  vpc_id = aws_vpc.vpc-1.id

  #ipv4
  route {
    cidr_block = "0.0.0.0/0" #send all trafic to here
      nat_gateway_id = aws_nat_gateway.nat-2.id
  }

  tags = {
    Name = "private-routetb-2"
  }
}

#routing table association with public-subnet-1
resource "aws_route_table_association" "public1" {
  subnet_id = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.routetb-1.id
}

#routing table association with public-subnet-2
resource "aws_route_table_association" "public2" {
  subnet_id = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.routetb-1.id
}

#routing table association with private-subnet-1
resource "aws_route_table_association" "private1" {
  subnet_id = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-routetb-1.id
}

#routing table association with private-subnet-2
resource "aws_route_table_association" "private2" {
  subnet_id = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-routetb-2.id
}