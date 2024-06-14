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

variable "INSTANCE_COUNT" {
    type = number
    default = 2
    description = "The number of instance to be created"

    validation {
      condition = var.INSTANCE_COUNT >= 1 && var.INSTANCE_COUNT <= 10
      error_message = "INSTANCE_COUNT must be a positive number and lower or equal to 10"
    }
}

variable "MAX_REPLICAS" {
    type = number
    default = 4
    description = "The maximum number of instance to be created when scaled up"

    validation {
      condition = var.MAX_REPLICAS <= 10
      error_message = "MAX_REPLICAS must be a positive number and greater or equal to INSTANCE_COUNT"
    }
}

variable "MIN_REPLICAS" {
    type = number
    default = 1
    description = "The minimum number of instance to be deleted when scaled down"

    validation {
      condition = var.MIN_REPLICAS >= 1
      error_message = "MIN_REPLICAS must be a positive number and lower or equal to INSTANCE_COUNT"
    }
}

variable "PROVISIONER_SCRIPT_PATH" {
    type = string
    default = "./config/ubuntu_provisioner.sh"
    description = "Shell script used to install docker and ansible tools"
}

variable "USERNAME" {
    type = string
    description = "Username in virtual machine instance"
    default = "crivera2093"
}
