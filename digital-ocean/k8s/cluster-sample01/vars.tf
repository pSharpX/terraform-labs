variable "DIGITALOCEAN_TOKEN" {
    type = string
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

variable "DO_DROPLET_DEFAULT_SIZE" {
    type = string
    default = "s-2vcpu-4gb"
}

variable "DO_DROPLET_SIZES" {
    type = map(string)
    default = {
      "s-1vcpu-1gb" = "s-1vcpu-1gb"
      "s-1vcpu-2gb" = "s-1vcpu-2gb"
      "s-2vcpu-2gb" = "s-2vcpu-2gb"
      "s-2vcpu-4gb" = "s-2vcpu-4gb"
      "s-4vcpu-8gb" = "s-4vcpu-8gb"
      "g-2vcpu-8gb" = "g-2vcpu-8gb"
      "g-4vcpu-16gb" = "g-4vcpu-16gb"
    }
}

variable "DO_K8S_VERSIONS" {
    type = map(string)
    default = {
        "latest": "1.27.2-do.0"
        "oldest": "1.24.13-do.0"
    }
}