# Internet Gateway
resource "aws_internet_gateway" "sh_gw" {
  vpc_id = aws_vpc.sh_main.id
}


# Elastic IP for NAT gateway
resource "aws_eip" "sh_eip" {
  depends_on = [aws_internet_gateway.sh_gw]
  vpc        = true
  tags = {
    Name = "sh_EIP_for_NAT"
  }
}

# NAT gateway for private subnets - for the private subnet to access internet
# like ec2 instances downloading softwares etc.
resource "aws_nat_gateway" "sh_nat_for_private_subnet" {
  allocation_id = aws_eip.sh_eip.id
  subnet_id     = aws_subnet.sh_subnet_1.id // nat should be in public subnet

  tags = {
    Name = "Sh NAT for private subnet"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.sh_gw]
}