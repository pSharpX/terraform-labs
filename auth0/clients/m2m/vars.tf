variable "API_TOKEN" {
    type = string
    description = "API Token used to consume Auth0 Management API"
}

variable "AUTH0_CLIENT_ID" {
    type = string
    description = "Auth0 Client ID used to consume Auth0 Management API"
}

variable "AUTH0_CLIENT_SECRET" {
    type = string
    description = "Auth0 Client Secret used to consume Auth0 Management API"
}

variable "AUTH0_AUDIENCE" {
    type = string
    description = "Default audience used to consume Auth0 Management API"
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
    default = "onebank"
    type = string
    description = "Custom API identifier"
}

variable "APPLICATION_NAME" {
    default = "onebank-taskmaster"
    type = string
    description = "Auth0 Client for TaskMaster application"
}

variable "ALLOWED_ORIGINS" {
    type = list(string)
    description = "List additional origins allowed to make CORS requests"
    default = [
        "http://localhost:15672"
    ]
}

variable "ALLOWED_WEB_ORIGINS" {
    type = list(string)
    description = "List additional origins allowed to make CORS requests"
    default = [
        "http://localhost:15672"
    ]
}

variable "ALLOWED_CALLBACK_URLS" {
    type = list(string)
    description = "After the user authenticates we will only call back to any of these URLs"
    default = [
        "http://localhost:15672/js/oidc-oauth/login-callback.html"
    ]
}
