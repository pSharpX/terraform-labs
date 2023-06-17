output "docker_server" {
    value = {
        "droplet_ip": digitalocean_droplet.droplet-docker-server.ipv4_address
    }
}
