provider "aws" {
  
}

variable "AWS_REGION" {
    type = string
}

variable "AMIS" {
  type = map(string)
  default = {
    "eu-west-1" = "my ami"
  }
}

resource "aws_instance" "ec2-vm-aforo255" {
    ami = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"
}