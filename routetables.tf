
# route table for public subnet - connecting to Internet gateway
resource "aws_route_table" "sh_rt_public" {
  vpc_id = aws_vpc.sh_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sh_gw.id
  }
}

# associate the route table with public subnet 1
resource "aws_route_table_association" "sh_rta1" {
  subnet_id      = aws_subnet.sh_subnet_1.id
  route_table_id = aws_route_table.sh_rt_public.id
}
# associate the route table with public subnet 1a
resource "aws_route_table_association" "sh_rta2" {
  subnet_id      = aws_subnet.sh_subnet_1a.id
  route_table_id = aws_route_table.sh_rt_public.id
}


# route table for private subnet - connecting to NAT
resource "aws_route_table" "sh_rt_private" {
  vpc_id = aws_vpc.sh_main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.sh_nat_for_private_subnet.id
  }
}

# associate the route table with private subnet 2
resource "aws_route_table_association" "sh_rta3" {
  subnet_id      = aws_subnet.sh_subnet_2.id
  route_table_id = aws_route_table.sh_rt_private.id
}
