#nat1
resource "aws_nat_gateway" "nat-1" {
  allocation_id = aws_eip.eip-1.id
  subnet_id = aws_subnet.public-subnet-1.id

  tags = {
    "Name" = "nat-1"
  }
}

#nat2
resource "aws_nat_gateway" "nat-2" {
  allocation_id = aws_eip.eip-2.id
  subnet_id = aws_subnet.public-subnet-2.id

  tags = {
    "Name" = "nat-2"
  }
}