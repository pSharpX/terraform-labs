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

variable "REGIONAL_KEYRING_ID" {
    type = string
    description = "Keyring that holds customer-managed keys (Regional)"
}

variable "REGIONAL_CMEK_ID" {
    type = string
    description = "Customer-managed encryption key for encrypting Secrets (Regional)"
}

variable "GLOBAL_KEYRING_ID" {
    type = string
    description = "Keyring that holds customer-managed keys (Global)"
}

variable "GLOBAL_CMEK_ID" {
    type = string
    description = "Customer-managed encryption key for encrypting Secrets (Global)"
}

variable "DB_PASSWORD" {
    type = string
    description = "Password value for accessing Database"
}

variable "DB_USER" {
    type = string
    description = "Username value for accessing Database"
}
