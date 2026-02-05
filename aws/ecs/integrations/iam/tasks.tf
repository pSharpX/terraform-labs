
# EC2, EXTERNAL, FARGATE, MANAGED_INSTANCES.

resource "aws_ecs_task_definition" "nginx_task" {
    family = local.task_definition_name
    cpu = 256
    memory = 512
    requires_compatibilities = [ "FARGATE" ]
    network_mode = "awsvpc"
    task_role_arn = aws_iam_role.ecs_task_role.arn
    container_definitions = jsonencode([
        {
            name = "${var.APPLICATION_NAME}"
            image = "nginx:latest"
            cpu = 10
            memory = 512
            memoryReservation = 256
            essential = true
            portMappings = [
                {
                    containerPort = 80
                    hostPort = 80
                }
            ]
            environment = [
                {
                    name = "ENV"
                    value = "DEV"
                },
                {
                    name = "APP_NAME"
                    value = "onebank"
                }
            ]
        }
    ])
    
    runtime_platform {
        operating_system_family = "LINUX"
        cpu_architecture = "X86_64"
    }
}