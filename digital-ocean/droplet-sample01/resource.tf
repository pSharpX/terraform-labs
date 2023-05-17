resource "digitalocean_ssh_key" "droplet-sample01-keypair" {
    name = "droplet-sample01-keypair"
    public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"
}

resource "digitalocean_droplet" "droplet-aforo255-01" {
    image = "ubuntu-20-04-x64"
    name = "droplet-aforo255-01"
    region = "nyc3"
    size = "s-1vcpu-1gb"
    user_data = "${file("userdata.yml")}"
    ssh_keys = [ "${digitalocean_ssh_key.droplet-sample01-keypair.fingerprint}" ]
}