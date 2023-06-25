resource "digitalocean_ssh_key" "jenkins-server-keypair" {
    name = "jenkins-server-keypair"
    public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"
}

resource "digitalocean_droplet" "droplet-jenkins-server" {
    image = "ubuntu-20-04-x64"
    name = "droplet-jenkins-server"
    region = "nyc3"
    size = element(data.digitalocean_sizes.do_nyc3_sizes.sizes, 0).slug
    ssh_keys = [
        "${digitalocean_ssh_key.jenkins-server-keypair.fingerprint}"
    ]

    provisioner "remote-exec" {
        inline = [ "sudo apt update", "sudo apt install python3 -y" ]

        connection {
            host = self.ipv4_address
            type = "ssh"
            user = "root"
            private_key = file(var.PATH_TO_PRIVATE_KEY)
        }
    }
}