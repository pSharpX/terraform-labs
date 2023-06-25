output "jenkins_server" {
    value = {
        "jenkins_server_ip": "${digitalocean_droplet.droplet-jenkins-server.ipv4_address}"
        "server_size": "${digitalocean_droplet.droplet-jenkins-server.size}"
    }
}

output "ansible_server" {
    value = {
        "ansible_server_ip": "${digitalocean_droplet.droplet-ansible-server.ipv4_address}"
        "server_size": "${digitalocean_droplet.droplet-ansible-server.size}"
    }
}
