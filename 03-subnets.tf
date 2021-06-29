resource "aws_subnet" "pub-subnets" {
  count             = "${length(var.azs)}"
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${element(var.pub-subnets, count.index)}"
  availability_zone = "${element(var.azs, count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-subnet-${count.index}"
  }
}

resource "aws_subnet" "priv-subnets" {
  count             = "${length(var.azs)}"
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${element(var.priv-subnets, count.index)}"
  availability_zone = "${element(var.azs, count.index)}"
  map_public_ip_on_launch = false

  tags = {
    Name = "priv-subnet-${count.index}"
  }
}   