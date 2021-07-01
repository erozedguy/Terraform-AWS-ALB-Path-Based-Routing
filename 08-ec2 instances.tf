resource "aws_instance" "app1-instances" {
  count             = "${length(var.azs)}"
  ami               = "ami-0aeeebd8d2ab47354"
  instance_type     = "t2.micro"
  availability_zone = element(var.azs, count.index)
  subnet_id         = aws_subnet.priv-subnets[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data         = file("bash-scripts/http1.sh")

  tags = {
    Name = "app1-${element(var.azs, count.index)}"
  }
}

resource "aws_instance" "init-instances" {
  count             = "${length(var.azs)}"
  ami               = "ami-0aeeebd8d2ab47354"
  instance_type     = "t2.micro"
  availability_zone = element(var.azs, count.index)
  subnet_id         = aws_subnet.priv-subnets[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data         = file("bash-scripts/http2.sh")

  tags = {
    Name = "init-${element(var.azs, count.index)}"
  }
}

resource "aws_instance" "app2-instances" {
  count             = "${length(var.azs)}"
  ami               = "ami-0aeeebd8d2ab47354"
  instance_type     = "t2.micro"
  availability_zone = element(var.azs, count.index)
  subnet_id         = aws_subnet.priv-subnets[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data         = file("bash-scripts/http3.sh")

  tags = {
    Name = "app2-${element(var.azs, count.index)}"
  }
}