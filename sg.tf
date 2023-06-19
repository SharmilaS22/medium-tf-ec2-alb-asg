# Security group
resource "aws_security_group" "sh_sg_for_elb" {
  name   = "sharmi-sg_for_elb"
  vpc_id = aws_vpc.sh_main.id

  # allow only http(80) and https(443)
  dynamic "ingress" {
    for_each = var.sg_ports_for_internet
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      description      = "Allow all request from anywhere"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "sh_sg_for_ec2" {
  name   = "sharmi-sg_for_ec2"
  vpc_id = aws_vpc.sh_main.id

  ingress {
    description     = "Allow http request from Load Balancer"
    protocol        = "tcp"
    from_port       = 80 # range of
    to_port         = 80 # port numbers
    security_groups = [aws_security_group.sh_sg_for_elb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}