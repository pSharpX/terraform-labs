variable "DIGITALOCEAN_TOKEN" {
    type = string
}

variable "PATH_TO_PRIVATE_KEY" {
    type = string
    default = "droplet-sample02-keypair"
}

variable "PATH_TO_PUBLIC_KEY" {
    type = string
    default = "droplet-sample02-keypair.pub"
}

variable "DO_DEFAULT_REGION" {
    type = string
    default = "nyc1"
}

variable "DO_REGIONS" {
    type = map(string)
    default = {
      "nyc1" = "nyc1"
      "nyc3" = "nyc3"
      "tor1" = "tor1"
    }
}

variable "PG_VERSIONS" {
    type = map(string)
    default = {
        "latest": "15"
        "oldest": "11"
    }
}

variable "DO_DB_DEFAULT_SIZE" {
    type = string
    default = "db-s-1vcpu-1gb"
}

variable "DO_DB_SIZES" {
    type = map(string)
    default = {
      "db-s-1vcpu-1gb" = "db-s-1vcpu-1gb"
      "db-s-1vcpu-2gb" = "db-s-1vcpu-2gb"
      "db-s-2vcpu-4gb" = "db-s-2vcpu-4gb"
      "db-s-4vcpu-8gb" = "db-s-4vcpu-8gb"
      "gd-2vcpu-8gb" = "gd-2vcpu-8gb"
      "gd-4vcpu-16gb" = "gd-4vcpu-16gb"
    }
}