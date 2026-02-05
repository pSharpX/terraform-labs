
resource "aws_ecs_service" "nginx_service" {
    name = "${local.task_definition_name}"
    cluster = aws_ecs_cluster.onebank_cluster.id
    task_definition = aws_ecs_task_definition.nginx_task.arn
    desired_count = 1
    tags = local.common_tags
    force_new_deployment = true

    network_configuration {
        subnets = [  
            data.aws_subnet.default_subnet.id
        ]
        security_groups = [
            aws_security_group.allow_traffic.id
        ]
    }

    capacity_provider_strategy {
        weight = 100
        base = 1
        capacity_provider = aws_ecs_capacity_provider.gp_cap_provider.name
    }

    depends_on = [
        time_sleep.wait_2_min
    ]
}
