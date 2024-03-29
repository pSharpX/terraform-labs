resource "local_file" "docker_manifest" {
    filename = "./config/Dockerrun.aws.json"
    content = jsonencode({
        AWSEBDockerrunVersion = "1"
        Image = {
            Name = "${var.IMAGE_NAME}:latest"
            Update = "true"
        },
        Ports = [{
            ContainerPort = "80"
        }]
    })
}

data "archive_file" "docker_run" {
    type = "zip"
    source_file = local_file.docker_manifest.filename
    output_path = "./config/Dockerrun.aws.zip"
}