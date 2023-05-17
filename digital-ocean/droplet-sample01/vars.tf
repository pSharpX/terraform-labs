variable "DIGITALOCEAN_TOKEN" {
    type = string
}

variable "PATH_TO_PRIVATE_KEY" {
    type = string
    default = "droplet-sample01-keypair"
}

variable "PATH_TO_PUBLIC_KEY" {
    type = string
    default = "droplet-sample01-keypair.pub"
}