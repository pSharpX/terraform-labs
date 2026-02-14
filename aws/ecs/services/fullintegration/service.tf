
resource "aws_ecs_service" "default_service" {
  name             = local.task_definition_name
  cluster          = aws_ecs_cluster.application_cluster.id
  task_definition  = aws_ecs_task_definition.application_task.arn
  desired_count    = 2
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    assign_public_ip = false
    subnets          = [for subnet in data.aws_subnet.private_subnets : subnet.id]
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = var.APPLICATION_NAME
    container_port   = var.APP_PORT
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  depends_on = [aws_lb_listener.listener]
}