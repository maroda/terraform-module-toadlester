data "aws_iam_policy_document" "ecspolicy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "ecstaskexec" {
  name               = "${var.app}-ecs-task-exec"
  assume_role_policy = data.aws_iam_policy_document.ecspolicy.json

  tags = {
    Name = "${var.app}-ecs-task-exec"
  }
}

resource "aws_iam_role" "ecstask" {
  name               = "${var.app}-ecs-task"
  assume_role_policy = data.aws_iam_policy_document.ecspolicy.json

  tags = {
    Name = "${var.app}-ecs-task"
  }
}

resource "aws_iam_policy_attachment" "ecstaskexec" {
  name       = "${var.app}-ecs-task-exec"
  roles      = [aws_iam_role.ecstaskexec.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy_attachment" "ecstask" {
  name       = "${var.app}-ecs-task"
  roles      = [aws_iam_role.ecstask.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
