locals {
    ANSIBLE_SERVER_PUB_KEY = "./ssh/ansible-kp.pub"
    ANSIBLE_SERVER_PVT_KEY = "./ssh/ansible-kp"
}

resource "digitalocean_ssh_key" "ansible-server-keypair" {
    name = "ansible-server-keypair"
    public_key = file(local.ANSIBLE_SERVER_PUB_KEY)
}

resource "digitalocean_droplet" "droplet-ansible-server" {
    image = "ubuntu-20-04-x64"
    name = "droplet-ansible-server"
    region = "nyc3"
    size = element(data.digitalocean_sizes.do_nyc3_small.sizes, 0).slug

    ssh_keys = [
        "${digitalocean_ssh_key.ansible-server-keypair.fingerprint}"
    ]

    provisioner "remote-exec" {
        inline = [
            "sudo apt-add-repository ppa:ansible/ansible -y",
            "sudo apt update",
            "sudo apt install tree python3 ansible -y",
            "mkdir /ansible/jenkins -p"
        ]

        connection {
            host = self.ipv4_address
            type = "ssh"
            user = "root"
            
            private_key = file(local.ANSIBLE_SERVER_PVT_KEY)
        }
    }

    provisioner "file" {
        source      = "./provisioner/"
        destination = "/ansible/jenkins"

        connection {
            host = self.ipv4_address
            type = "ssh"
            user = "root"
            private_key = file(local.ANSIBLE_SERVER_PVT_KEY)
        }
    }

    provisioner "file" {
        destination = "/ansible/jenkins/inventory"
        content = templatefile("./templates/inventory.tmpl", {
            jenkins_server = digitalocean_droplet.droplet-jenkins-server.ipv4_address
        })

        connection {
            host = self.ipv4_address
            type = "ssh"
            user = "root"
            private_key = file(local.ANSIBLE_SERVER_PVT_KEY)
        }
    }

    provisioner "file" {
        source      = "./ssh/rsa"
        destination = "/ansible/jenkins/rsa"

        connection {
            host = self.ipv4_address
            type = "ssh"
            user = "root"
            private_key = file(local.ANSIBLE_SERVER_PVT_KEY)
        }
    }

    provisioner "remote-exec" {
        inline = [
            "sudo chmod 600 /ansible/jenkins/rsa",
            "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --inventory-file '/ansible/jenkins/inventory' --private-key '/ansible/jenkins/rsa' /ansible/jenkins/playbook.yaml"
        ]

        connection {
            host = self.ipv4_address
            type = "ssh"
            user = "root"
            private_key = file(local.ANSIBLE_SERVER_PVT_KEY)
        }
    }

    depends_on = [ 
        digitalocean_droplet.droplet-jenkins-server 
    ]
}