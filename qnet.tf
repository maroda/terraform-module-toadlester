resource "aws_cloudwatch_log_group" "qnetlogs" {
  name              = var.qnet
  retention_in_days = 0

  tags = {
    Name = var.qnet
  }
}

resource "aws_ecs_task_definition" "qnettask" {
  family                   = var.qnet
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecstaskexec.arn

  depends_on = [aws_cloudwatch_log_group.qnetlogs]

  container_definitions = <<TASK
[
    {
        "image": "${var.qnetrepository}:${var.qnetrelease}",
        "name": "${var.qnet}",
        "environment": [
            {
                "name": "OTEL_RESOURCE_ATTRIBUTES",
                "value": "service.name=monteverdi"
            },
            {
                "name": "OTEL_EXPORTER_OTLP_ENDPOINT",
                "value": "https://otlp-gateway-prod-us-west-0.grafana.net/otlp"
            }
        ],
        "secrets": [
            {
                "name": "OTEL_EXPORTER_OTLP_HEADERS",
                "valueFrom": "arn:aws:secretsmanager:us-west-2:821445872109:secret:grafana/otel/header-z2qbpC"
            }
        ],
        "essential": true,
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${var.qnet}",
                "awslogs-region": "${var.aws_region}",
                "awslogs-stream-prefix": "ecs"
            }
        },
        "portMappings": [
            {
                "protocol": "tcp",
                "containerPort": ${var.qnetport}
            }
        ]
    }
]
TASK
}

resource "aws_ecs_service" "qnetserv" {
  name             = var.qnet
  cluster          = aws_ecs_cluster.appcluster.arn
  task_definition  = aws_ecs_task_definition.qnettask.arn
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  desired_count = 1

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_count]
  }

  force_new_deployment = true

  network_configuration {
    security_groups  = [aws_security_group.qnettaskaccess.id]
    subnets          = aws_subnet.private_az.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.qnetlbtarget.arn
    container_name   = var.qnet
    container_port   = var.qnetport
  }

}

resource "aws_iam_role_policy" "ecstaskexec_secrets" {
  name = "secrets-access"
  role = aws_iam_role.ecstaskexec.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "arn:aws:secretsmanager:us-west-2:821445872109:secret:grafana/otel/header-z2qbpC"
      }
    ]
  })
}
