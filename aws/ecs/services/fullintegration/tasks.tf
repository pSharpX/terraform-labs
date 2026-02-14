
resource "aws_ecs_task_definition" "application_task" {
  family                   = local.task_definition_name
  cpu                      = var.APP_TOTAL_CPU
  memory                   = var.APP_TOTAL_MEM
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode([
    {
      name      = "${var.APPLICATION_NAME}"
      image     = "${var.APP_IMAGE_NAME}:${var.APP_IMAGE_VERSION}"
      cpu       = var.APP_CPU
      memory    = var.APP_MEM
      essential = true
      portMappings = [
        {
          containerPort = var.APP_PORT
          hostPort      = var.APP_PORT
        }
      ]
      environment = [
        {
          name  = "ENV"
          value = var.ENVIRONMENT
        },
        {
          name  = "APP_NAME"
          value = var.APPLICATION_NAME
        }
      ]
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost/ || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 10
      }
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}