resource "aws_subnet" "public_subnet1" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = element(var.public_subnet, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "stage-public1-${count.index + 1}"
  }
}



resource "aws_subnet" "private_subnet1" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = element(var.private_subnet, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "stage-public1-${count.index + 1}"
  }
}


resource "aws_subnet" "data_subnet1" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = element(var.data_subnet, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "stage-public1-${count.index + 1}"
  }
}
