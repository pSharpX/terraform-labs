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

variable "AMIS" {
    type = map(string)
    default = {
      "us-east-1" = "ami-03c7d01cf4dedc891"
      "us-east-2" = "ami-03c7d01cf4dedc891"
      "us-west-1" = "ami-03c7d01cf4dedc891"
      "us-west-2" = "ami-03c7d01cf4dedc891"
    }
}

variable "PATH_TO_PUBLIC_KEY" {
    type = string
    default = "ec2-sample04-keypair.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
    type = string
    default = "ec2-sample04-keypair"
}

variable "INSTANCE_USERNAME" {
    type = string
    default = "ec2-user"
}