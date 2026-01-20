resource "aws_lb" "applb" {
  name               = var.app
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.pubaccess.id]
  subnets            = aws_subnet.private_az.*.id

  tags = {
    Name = var.app
  }
}

resource "aws_lb_listener" "public" {
  load_balancer_arn = aws_lb.applb.arn
  port              = var.port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lbtarget.arn
  }
}

resource "aws_lb_target_group" "lbtarget" {
  name        = var.app
  port        = var.port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    unhealthy_threshold = "2"
    path                = "/metrics"
    port                = var.port
  }
}

resource "aws_lb" "qnetlb" {
  name               = var.qnet
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.qnetaccess.id]
  subnets            = aws_subnet.private_az.*.id

  tags = {
    Name = var.qnet
  }
}

resource "aws_lb_listener" "qnetpublic" {
  load_balancer_arn = aws_lb.qnetlb.arn
  port              = var.qnetport
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.qnetlbtarget.arn
  }
}

resource "aws_lb_listener" "qnethttps" {
  load_balancer_arn = aws_lb.qnetlb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.apexcert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.qnetlbtarget.arn
  }
}


resource "aws_lb_target_group" "qnetlbtarget" {
  name        = var.qnet
  port        = var.qnetport
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    unhealthy_threshold = "2"
    path                = "/"
    port                = var.qnetport
  }
}