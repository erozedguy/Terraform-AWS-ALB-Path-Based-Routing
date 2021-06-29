resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_vpc}"

  tags = {
    Name = "custom-vpc"
  }
}