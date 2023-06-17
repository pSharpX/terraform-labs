resource "digitalocean_ssh_key" "docker-server-keypair" {
    name = "docker-server-keypair"
    public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"
}

resource "digitalocean_droplet" "droplet-docker-server" {
    image = "ubuntu-20-04-x64"
    name = "droplet-docker-server"
    region = "nyc3"
    size = "s-2vcpu-4gb"
    user_data = "${file(var.PATH_CLOUD_INIT_FILE)}"
    ssh_keys = [
        "${digitalocean_ssh_key.docker-server-keypair.fingerprint}"
    ]
}