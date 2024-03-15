variable "AWS_REGION" {
    type = string
    default = "us-east-1"
}

variable "AWS_ACCESS_KEY" {
    type = string
}

variable "AWS_SECRET_KEY" {
    type = string  
}

variable "PATH_TO_PUBLIC_KEY" {
    type = string
    default = "./ssh/ec2-keypair.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
    type = string
    default = "./ssh/ec2-keypair"
}

variable "PATH_TO_USER_DATA" {
    type = string
    default = "./config/userdata-ubuntu.yml"
    # default = "./config/ubuntu_provisioner.sh"
}

variable "PATH_TO_SITE_TEMPLATE" {
    type = string
    default = "./content/index.html"
}