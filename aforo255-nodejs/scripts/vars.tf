variable "DIGITALOCEAN_TOKEN" {
    type = string
}

variable "PATH_TO_PRIVATE_KEY" {
    type = string
    default = "./ssh/docker_server_kp"
}

variable "PATH_TO_PUBLIC_KEY" {
    type = string
    default = "./ssh/docker_server_kp.pub"
}

variable "PATH_NACOS_CONFIG" {
    type = string
    default = "./templates/nacos_config.tmpl"
}

variable "PATH_CLOUD_INIT_FILE" {
    type = string
    default = "./provisioner/userdata.yml"
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
        "oldest": "12"
    }
}

variable "MONGO_VERSIONS" {
    type = map(string)
    default = {
        "latest": "6"
        "oldest": "4.4"
    }
}

variable "MYSQL_VERSIONS" {
    type = map(string)
    default = {
        "latest": "8"
    }
}

variable "REDIS_VERSIONS" {
    type = map(string)
    default = {
        "latest": "7"
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
        "latest": "1.26.3-do.0"
        "oldest": "1.24.12-do.0"
    }
}