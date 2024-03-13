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

variable "S3_BUCKET" {
    type = string
    description = "S3 bucket name used as example"
}