resource "digitalocean_container_registry" "registry-sample01" {
    name = "registry-sample01"
    subscription_tier_slug = "starter"
    region = "nyc3"
}

resource "digitalocean_container_registry_docker_credentials" "registry_docker_credentials" {
    registry_name = "${digitalocean_container_registry.registry-sample01.name}"
}