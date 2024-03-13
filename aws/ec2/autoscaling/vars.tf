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

variable "APPLICATION_ID" {
    default = "onebank"
    type = string
    description = "Application Identifier"
}

variable "ENVIRONMENT" {
    default = "dev"
    type = string
    description = "Environment where resources are provisioned"

    validation {
      condition = contains(["dev", "uat", "staging", "prod"], var.ENVIRONMENT)
      error_message = "Allowed values for ENVIRONMENT are [dev, uat, staging, prod]"
    }
}

variable "TECHNICAL_OWNER" {
    default = "TeamGOAT"
    type = string
    description = "Team responsable for application support"
}

variable "PROVISIONER" {
    default = "Terraform"
    type = string
    description = "Tool used to provision resources"  
}

variable "DATA_CLASSIFICATION" {
    default = "Restricted"
    type = string
    description = "A classification for the type of data managed by resources"
}

variable "VPC_ID" {
    type = string
    description = "already provisioned vpc"
}

variable "DB_SUBNETS" {
    type = list(string)
    description = "list of subnets where rds instance will be located"
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
}