resource "digitalocean_ssh_key" "droplet-sample02-keypair" {
    name = "droplet-sample02-keypair"
    public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"
}

resource "digitalocean_droplet" "droplet-sample02" {
    image = "ubuntu-20-04-x64"
    name = "droplet-sample02"
    region = "nyc3"
    size = "s-1vcpu-1gb"
    ssh_keys = [
        digitalocean_ssh_key.droplet-sample02-keypair.id
    ]

    connection {
        host = self.ipv4_address
        user =  "root"
        type = "ssh"
        private_key = file(var.PATH_TO_PRIVATE_KEY)
        timeout = "2m"
    }

    provisioner "remote-exec" {
        inline = [ 
            "export PATH=$PATH:/usr/bin",
            "sudo apt update",
            "sudo apt install -y nginx"
         ]
    }
}