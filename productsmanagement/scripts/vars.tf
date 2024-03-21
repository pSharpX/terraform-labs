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
    default = "aforo255"
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

variable "DB_USERNAME" {
    default = "teamgoat"
    type = string
    description = "admin user for the database"
}

variable "DB_PASSWORD" {
    type = string
    sensitive = true
    description = "Password to be set to the default user"
}

variable "VPC_ID" {
    type = string
    description = "already provisioned vpc"
}

variable "PUBLIC_SUBNETS" {
    type = list(string)
    description = "list of public subnets where ec2 instance will run"
}

variable "PRIVATE_SUBNETS" {
    type = list(string)
    description = "list of private subnets where rds instance will run"
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

variable "PATH_TO_SITE_TEMPLATE" {
    type = string
    default = "./content/index.html"
}

variable "DB_ENGINE" {
    type = string
    default = "postgres"
    description = "Choosen DB Engine to be provisioned with RDS"

    validation {
      condition = contains(["mariadb", "mysql", "postgres", "sqlserver-se"], var.DB_ENGINE)
      error_message = "Allowed values for DB_ENGINE are [mariadb, mysql, postgres, sqlserver-se]"
    }
}