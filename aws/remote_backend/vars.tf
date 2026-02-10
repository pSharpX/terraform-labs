variable "AWS_REGION" {
  type    = string
  default = "us-east-1"
}

variable "APPLICATION_ID" {
  default     = "onebank"
  type        = string
  description = "Application Identifier"
}

variable "ENVIRONMENT" {
  default     = "dev"
  type        = string
  description = "Environment where resources are provisioned"

  validation {
    condition     = contains(["dev", "uat", "staging", "prod"], var.ENVIRONMENT)
    error_message = "Allowed values for ENVIRONMENT are [dev, uat, staging, prod]"
  }
}

variable "TECHNICAL_OWNER" {
  default     = "TeamLVX"
  type        = string
  description = "Team responsable for application support"
}

variable "PROVISIONER" {
  default     = "Terraform"
  type        = string
  description = "Tool used to provision resources"
}

variable "DATA_CLASSIFICATION" {
  default     = "Restricted"
  type        = string
  description = "A classification for the type of data managed by resources"
}
