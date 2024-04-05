resource "local_file" "docker_manifest" {
    filename = "./config/Dockerrun.aws.json"
    content = jsonencode({
        AWSEBDockerrunVersion = 2
        containerDefinitions = [
            {
                name = "backend"
                image = "${var.IMAGE_NAME}:latest"
                cpu = 256,
                memory = 512
                essential = true
                environment = [
                    {
                        name = "SPRING_DATASOURCE_URL"
                        value = "jdbc:postgresql://${var.DB_HOSTNAME}/${var.DB_NAME}"
                    },
                    {
                        name = "SPRING_DATASOURCE_USERNAME"
                        value = "${var.DB_USERNAME}"
                    }
                ]
                portMappings = [{
                    hostPort = 80
                    containerPort = 80
                    protocol = "tcp"
                }]
                healthCheck = {
                    command = [
                        "CMD-SHELL",
                        "curl -f http://127.0.0.1:80${var.HEALTH_CHECK} || exit 1"
                    ]
                    interval = 30
                    timeout = 5
                    retries = 10
                    startPeriod = 120
                }
                # logConfiguration = {
                #     logDriver = "awslogs"
                #     options = {
                #         awslogs-datetime-format = "%Y-%m-%d %H:%M:%S"
                #         awslogs-group = "${aws_cloudwatch_log_group.onebank_application_lg.name}"
                #         awslogs-stream-prefix = "ecs"
                #         awslogs-region = "${var.AWS_REGION}"
                #         mode = "non-blocking"
                #     }
                # },
            }
        ]
    })
}

data "archive_file" "docker_run" {
    type = "zip"
    source_file = local_file.docker_manifest.filename
    output_path = "./config/Dockerrun.aws.zip"
}