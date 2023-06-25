data "digitalocean_sizes" "do_nyc3_sizes" {
    filter {
        key = "vcpus"
        values = [ 2 ]
    }

    filter {
        key = "memory"
        values = [ 4096 ]
    }

    filter {
        key = "regions"
        values = [ "nyc3" ]
    }

    sort {
        key = "price_monthly"
        direction = "asc"
    }
}

data "digitalocean_sizes" "do_nyc3_small" {
    filter {
        key = "vcpus"
        values = [ 1 ]
    }

    filter {
        key = "memory"
        values = [ 2048 ]
    }

    filter {
        key = "regions"
        values = [ "nyc3" ]
    }

    sort {
        key = "price_monthly"
        direction = "asc"
    }
}