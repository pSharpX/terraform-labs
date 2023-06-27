resource "digitalocean_droplet" "ansible_server" {
    image = "ubuntu-20-04-x64"
    name = "droplet-ansible-server"
    region = "nyc3"
    size = element(data.digitalocean_sizes.do_nyc3_small.sizes, 0).slug
    user_data = "${data.template_file.ansible_install.rendered}"

    ssh_keys = [
        "${digitalocean_ssh_key.ansible_server_kp.fingerprint}"
    ]

    depends_on = [ 
        local_file.cloudinit_file 
    ]
}