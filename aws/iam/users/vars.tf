variable "AWS_REGION" {
    type = string
    default = "us-east-1"
}

variable "AWS_ACCESS_KEY" {
    type = string
    sensitive = true
    description = "AWS credentials (accessKey)"
}

variable "AWS_SECRET_KEY" {
    type = string
    sensitive = true
    description = "AWS credentials (secretKey)"
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

    validation {
        condition = contains(["Restricted", "Public", "Confidential"], var.DATA_CLASSIFICATION)
        error_message = "Allowed values for DATA_CLASSIFICATION are [Restricted, Public, Confidential]"
    }
}

variable "DEVELOPER_GROUP" {
    type = string
    default = "developers"
    description = "Group name for developer users with restricted permissions"
}

variable "ADMINISTRATOR_GROUP" {
    type = string
    default = "administrators"
    description = "Group name for administrator users with full access"
}

variable "GROUPS" {
    type = list(string)
    default = [ "guests", "contractors", "externals" ]
    description = "Groups name for external users with limit permissions"
}

variable "DEVELOVER_USERS" {
    type = set(string)
    default = [ "developer-1", "developer-2", "developer-3" ]
    description = "Users will belongs to Developer Group"
}

variable "ADMINISTRATOR_USERS" {
    type = set(string)
    default = [ "admin-1", "admin-2", "admin-3" ]
    description = "Users will belong to Administrator Group"
}

variable "EXTERNAL_USER" {
    type = string
    description = "User will belong to External Group with limited access"
}

variable "GUEST_USER" {
    type = string
    description = "User will belong to Guest Group with limited access"
}

variable "CONTRACTOR_USER" {
    type = string
    description = "User will belong to Contractor Group with limited access"
}