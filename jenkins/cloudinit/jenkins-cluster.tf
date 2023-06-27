resource "digitalocean_droplet" "jenkins_server" {
    image = "ubuntu-20-04-x64"
    name = "droplet-jenkins-server"
    region = "nyc3"
    size = element(data.digitalocean_sizes.do_nyc3_sizes.sizes, 0).slug
    user_data = file("./data/server_install.yaml")

    ssh_keys = [
        "${digitalocean_ssh_key.jenkins_server_kp.fingerprint}"
    ]
}