resource "local_file" "docker_config" {
    content = digitalocean_container_registry_docker_credentials.registry_docker_credentials.docker_credentials
    filename = "dockerconfig.json"
}