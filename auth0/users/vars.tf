variable "API_TOKEN" {
    type = string
    description = "API Token used to consume Auth0 Management API"
}

variable "DOMAIN" {
    type = string
    description = "Auth0 tenant domain"
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

variable "RESOURCE_SERVER_NAME" {
    default = "onebank-rabbitmq"
    type = string
    description = "Custom API identifier"
}

variable "DEFAULT_CONNECTION" {
    default = "Username-Password-Authentication"
    type = string
    description = "Default connection for users being sourced"
}

variable "USER_PWD" {
    type = string
    description = "Password for used being provisioned"
}

variable "ROLE_ID" {
    type = string
    description = "Existent role to be assigned to provisioned user"
}