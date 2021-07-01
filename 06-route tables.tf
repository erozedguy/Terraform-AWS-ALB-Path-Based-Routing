# TABLE FOR PUBLIC SUBNETS
resource "aws_route_table" "pub-table" {
  vpc_id    = "${aws_vpc.vpc.id}"
}

resource "aws_route" "pub-route" {
  route_table_id         = "${aws_route_table.pub-table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.i-gateway.id }"
}

resource "aws_route_table_association" "as-pub" {
  count          = "${length(var.pub-subnets)}"
  route_table_id = "${aws_route_table.pub-table.id}"
  subnet_id      = "${aws_subnet.pub-subnets[count.index].id}"  
}
# TABLEs FOR PRIVATE SUBNETS
resource "aws_route_table" "priv-table" {
  count  = "${length(var.priv-subnets)}"
  vpc_id = "${aws_vpc.vpc.id}"  
}

resource "aws_route" "priv-route" {
  count                  = "${length(var.priv-subnets)}"
  route_table_id         = "${aws_route_table.priv-table[count.index].id}" 
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat-gtw[count.index].id}"
}

resource "aws_route_table_association" "as-priv" {
  count          = "${length(var.priv-subnets)}"
  route_table_id = "${aws_route_table.priv-table[count.index].id}" 
  subnet_id      = "${aws_subnet.priv-subnets[count.index].id}"
}