
resource "aws_ecs_service" "nginx_service" {
    name = "${local.task_definition_name}"
    cluster = aws_ecs_cluster.onebank_cluster.id
    task_definition = aws_ecs_task_definition.nginx_task.arn
    desired_count = 1
    launch_type = "FARGATE"
    platform_version = "LATEST"

    network_configuration {
        assign_public_ip = true
        subnets = [  
            data.aws_subnet.default_subnet.id
        ]
    }

}