variable "REGION" {
    type = string
    default = "us-central1"
    description = "Region where resources will be located"
}

variable "LOCATION_ID" {
    type = string
    default = "us-central"
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

variable "DEFAULT_NETWORK" {
    type = string
    description = "Default network where instance will be allocated"
}

variable "NODE_COUNT" {
    type = number
    default = 2
    description = "Number of nodes for K8S cluster"
}