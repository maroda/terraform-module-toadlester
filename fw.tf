resource "aws_security_group" "pubaccess" {
  vpc_id = aws_vpc.vpc.id
  name   = var.app

  ingress {
    protocol    = "tcp"
    from_port   = var.port
    to_port     = var.port
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.app
  }
}

resource "aws_security_group" "taskaccess" {
  vpc_id = aws_vpc.vpc.id
  name   = "${var.app}-pri"

  ingress {
    protocol        = "tcp"
    from_port       = var.port
    to_port         = var.port
    security_groups = [aws_security_group.pubaccess.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app}-pri"
  }
}

resource "aws_security_group" "qnetaccess" {
  vpc_id = aws_vpc.vpc.id
  name   = var.qnet

  ingress {
    protocol    = "tcp"
    from_port   = var.qnetport
    to_port     = var.qnetport
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.qnet
  }
}

resource "aws_security_group" "qnettaskaccess" {
  vpc_id = aws_vpc.vpc.id
  name   = "${var.qnet}-pri"

  ingress {
    protocol        = "tcp"
    from_port       = var.qnetport
    to_port         = var.qnetport
    security_groups = [aws_security_group.qnetaccess.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.qnet}-pri"
  }
}
