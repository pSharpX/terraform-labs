variable "REGION" {
    type = string
    default = "us-central1"
    description = "Region where resources will be located"
}

variable "ZONE" {
    type = string
    default = "us-central1-a"
    description = "Zone where resources will be located"
}

variable "CREDENTIALS_FILE" {
    type = string
    sensitive = true
    description = "GCP credentials"
}

variable "PROJECT_ID" {
    type = string
    description = "The ID of the project in which the resource belongs"
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
    default = "team_goat"
    type = string
    description = "Team responsable for application support"
}

variable "PROVISIONER" {
    default = "terraform"
    type = string
    description = "Tool used to provision resources"  
}

variable "DATA_CLASSIFICATION" {
    default = "restricted"
    type = string
    description = "A classification for the type of data managed by resources"
}

variable "PROVISIONER_SCRIPT_PATHS" {
    type = map(string)
    default = {
        DEBIAN = "./config/debian_provisioner.sh"
        UBUNTU = "./config/ubuntu_provisioner.sh"
        FEDORA = "./config/fedora_provisioner.sh"
        RHEL = "./config/rhel_provisioner.sh"
    }
    description = "Shell script used to install docker and ansible tools per linux distribution"
}

variable "PUBLIC_KEY" {
    type = string
    default = "./ssh/ec2-keypair.pub"
}

variable "USERNAME" {
    type = string
    description = "Username in virtual machine instance"
    default = "crivera2093"
}
