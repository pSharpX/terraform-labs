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

variable "PRODUCER_ROLE" {
    default = "api://rabbitmq:producer"
    type = string
    description = "Custom role for rabbitmq users with producer permissions"
}

variable "CONSUMER_ROLE" {
    default = "api://rabbitmq:consumer"
    type = string
    description = "Custom role for rabbitmq users with consumer permissions"
}

variable "ADMINISTRATOR_ROLE" {
    default = "api://rabbitmq:Administrator"
    type = string
    description = "Custom role for rabbitmq users with Administrator permissions"
}