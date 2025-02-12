
variable "ORG_NAME" {
    type = string
    description = "Org name of your Okta account"
}

variable "BASE_URL" {
    type = string
    description = "Domain of your Okta account"
}

variable "API_TOKEN" {
    type = string
    description = "API Token used to consume Okta Management API"
}

variable "OKTA_CLIENT_ID" {
    type = string
    description = "Okta Client ID used to consume Okta Management API"
}

variable "OKTA_CLIENT_SECRET" {
    type = string
    description = "Okta Client Secret used to consume Okta Management API"
}

variable "OKTA_AUDIENCE" {
    type = string
    description = "Default audience used to consume Okta Management API"
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

variable "USER_PWD" {
    type = string
    description = "Password for used being provisioned"
}