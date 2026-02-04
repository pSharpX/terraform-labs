
resource "aws_ecs_task_definition" "nginx_task" {
    family = local.task_definition_name
    cpu = 256
    memory = 512
    requires_compatibilities = [ "MANAGED_INSTANCES" ]
    network_mode = "awsvpc"
    container_definitions = file("task-definition/service.json")
    
    runtime_platform {
        operating_system_family = "LINUX"
        cpu_architecture = "X86_64"
    }
}