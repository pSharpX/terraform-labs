resource "local_file" "docker_manifest" {
    filename = "./config/Dockerrun.aws.json"
    content = jsonencode({
        AWSEBDockerrunVersion = 2
        containerDefinitions = [
            {
                name = "backend"
                image = "${var.IMAGE_NAME}:latest"
                cpu = 256,
                memoryReservation = 512
                essential = true
                environment = [
                    {
                        name = "SPRING_DATASOURCE_URL"
                        value = "jdbc:postgresql://${aws_db_instance.onebank_database.address}/${local.database_name}"
                    },
                    {
                        name = "SPRING_DATASOURCE_USERNAME"
                        value = var.DB_USERNAME
                    }
                ]
                portMappings = [{
                    hostPort = 80
                    containerPort = 80
                }]
            }
        ]
    })
}

data "archive_file" "docker_run" {
    type = "zip"
    source_file = local_file.docker_manifest.filename
    output_path = "./config/Dockerrun.aws.zip"
}