resource "digitalocean_loadbalancer" "loadbalancer" {
    name = "loadbalancer"
    region = "nyc3"

    forwarding_rule {
        entry_port = 80
        entry_protocol = "http"

        target_port = 80
        target_protocol = "http"
    }

    healthcheck {
        port = 22
        protocol = "tcp"
    }

    droplet_ids = [ 
        digitalocean_droplet.server01.id,
        digitalocean_droplet.server02.id
     ]
}