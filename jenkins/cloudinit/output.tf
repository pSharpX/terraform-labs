output "jenkins_server" {
    value = {
        "jenkins_server_ip": "${digitalocean_droplet.jenkins_server.ipv4_address}"
        "server_size": "${digitalocean_droplet.jenkins_server.size}"
    }
}

output "ansible_server" {
    value = {
        "ansible_server_ip": "${digitalocean_droplet.ansible_server.ipv4_address}"
        "server_size": "${digitalocean_droplet.ansible_server.size}"
    }
}
