resource "digitalocean_ssh_key" "ansible_server_kp" {
    name = "ansible_server_kp"
    public_key = file(var.ANSIBLE_PUB_KEY_PATH)
}

resource "digitalocean_ssh_key" "jenkins_server_kp" {
    name = "jenkins_server_kp"
    public_key = "${file(var.JENKINS_PUB_KEY_PATH)}"
}