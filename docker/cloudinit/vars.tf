variable "DIGITALOCEAN_TOKEN" {
    type = string
}

variable "PATH_TO_PRIVATE_KEY" {
    type = string
    default = "./ssh/rsa"
}

variable "PATH_TO_PUBLIC_KEY" {
    type = string
    default = "./ssh/rsa.pub"
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