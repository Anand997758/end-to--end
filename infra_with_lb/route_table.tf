resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public_Route_table"
  }

}

resource "aws_route_table" "Private_route" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "Private_Route_table"
  }

}

resource "aws_route_table" "data_route" {
  vpc_id = aws_vpc.vpc1.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "data_Route_table"
  }

}


resource "aws_route_table_association" "public_association1" {
  count          = length(var.public_subnet)
  subnet_id      = element(aws_subnet.public_subnet1.*.id, count.index)
  route_table_id = aws_route_table.public_route.id

}

resource "aws_route_table_association" "private_association1" {
  count          = length(var.private_subnet)
  subnet_id      = element(aws_subnet.private_subnet1.*.id, count.index)
  route_table_id = aws_route_table.Private_route.id

}

resource "aws_route_table_association" "data_association1" {
  count          = length(var.data_subnet)
  subnet_id      = element(aws_subnet.data_subnet1.*.id, count.index)
  route_table_id = aws_route_table.data_route.id

}
