
# Target group vs Auto scaling group
# https://stackoverflow.com/a/53322509
# https://stackoverflow.com/a/52364066

resource "aws_lb" "sh_lb" {
  name               = "sharmi-lb-asg"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sh_sg_for_elb.id]
  subnets            = [aws_subnet.sh_subnet_1.id, aws_subnet.sh_subnet_1a.id]
  depends_on         = [aws_internet_gateway.sh_gw]
}

resource "aws_lb_target_group" "sh_alb_tg" {
  name     = "sh-tf-lb-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.sh_main.id
}

resource "aws_lb_listener" "sh_front_end" {
  load_balancer_arn = aws_lb.sh_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sh_alb_tg.arn
  }
}