resource "digitalocean_droplet" "server01" {
    name = "server01"
    region = "nyc3"
    image = "ubuntu-20-04-x64"
    size = "s-1vcpu-1gb"
    ssh_keys = [
        digitalocean_ssh_key.loadbalancer-keypair.id
     ]

     connection {
        host = self.ipv4_address
        user = "root"
        type = "ssh"
        private_key = "${file(var.PATH_TO_PRIVATE_KEY)}"
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