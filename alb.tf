#alb target group
resource "aws_lb_target_group" "target-group-1" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "alb-target-1"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc-1.id
}

#alb
resource "aws_lb" "aws-alb-1" {
  name     = "alb-1"
  internal = false

  security_groups = [aws_security_group.scgroup-1.id]
  subnets = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]

  tags = {
    Name = "alb-1"
  }

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

#alb listener
resource "aws_lb_listener" "alb-listner-1" {
  load_balancer_arn = aws_lb.aws-alb-1.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group-1.arn
  }
}