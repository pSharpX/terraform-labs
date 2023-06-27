variable "DIGITALOCEAN_TOKEN" {
    type = string
}

variable "JENKINS_PUB_KEY_PATH" {
    type = string
    default = "./ssh/rsa.pub"
}

variable "JENKINS_PVT_KEY_PATH" {
    type = string
    default = "./ssh/rsa"
}

variable "ANSIBLE_PUB_KEY_PATH" {
    type = string
    default = "./ssh/ansible_rsa.pub"
}

variable "ANSIBLE_PVT_KEY_PATH" {
    type = string
    default = "./ssh/ansible_rsa"
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