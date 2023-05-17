resource "digitalocean_ssh_key" "loadbalancer-keypair" {
    name = "loadbalancer-keypair"
    public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"
}