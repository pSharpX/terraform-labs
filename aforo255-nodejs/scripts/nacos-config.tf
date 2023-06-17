resource "local_file" "nacos_config" {
    content = templatefile(var.PATH_NACOS_CONFIG, {
        droplet_ipv4_address = "${digitalocean_droplet.droplet-docker-server.ipv4_address}"
    })
    filename = "./configs/nacos_config.json"
}