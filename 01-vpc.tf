resource "aws_vpc" "name" {
  cidr_block = "${var.cidr_vpc}"

  tags = {
    Name = "custom-vpc"
  }
}