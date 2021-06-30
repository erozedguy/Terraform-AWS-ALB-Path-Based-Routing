resource "aws_eip" "e-ip" {
  count = "${length(var.azs)}"
  vpc   = true
  depends_on = [
    aws_internet_gateway.i-gateway
  ]

  tags = {
    Name = "eip-${count.index}"
  }
}

resource "aws_nat_gateway" "nat-gtw" {
  count         = "${length(var.azs)}"
  allocation_id = "${aws_eip.e-ip[count.index].id}"
  subnet_id     = "${aws_subnet.pub-subnets[count.index].id}"
  connectivity_type = "public"
  depends_on = [
    aws_internet_gateway.i-gateway
  ]

  tags = {
    Name = "nat-g-${count.index}"
  }
}