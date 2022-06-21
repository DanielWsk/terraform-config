resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public" {
  for_each = var.public_subnet_azs

  vpc_id            = aws_vpc.main.id
  availability_zone = each.key

  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, each.value)

  tags = {
    Name      = "public-subet-${each.value}"
    ManagedBy = "terraform"
    Subnet    = "${each.key}-${each.value}"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnet_azs

  vpc_id            = aws_vpc.main.id
  availability_zone = each.key

  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, each.value)

  tags = {
    Name      = "private-subet-${each.value}"
    ManagedBy = "terraform"
    Subnet    = "${each.key}-${each.value}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "internet_gateway_route" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  route_table_id         = aws_route_table.public.id
  depends_on             = [aws_route_table.public]
}

resource "aws_route_table_association" "public_subnet" {
  for_each = aws_subnet.public

  route_table_id = aws_route_table.public.id
  subnet_id      = each.value.id
}
