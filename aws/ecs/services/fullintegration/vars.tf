variable "AWS_REGION" {
  type    = string
  default = "us-east-1"
}

variable "APPLICATION_ID" {
  default     = "lvx-secret-friend"
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
  default     = "TeamLvX"
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

variable "CLUSTER_NAME" {
  default     = "lvx-factory"
  type        = string
  description = "ECS cluster to manage all workload"
}

variable "APPLICATION_NAME" {
  default     = "lvx-secret-friend"
  type        = string
  description = "An containarized application running on ECS cluster"
}

variable "VPC_ID" {
  type        = string
  description = "Virtual Private Cloud on which resources will be located"
}

variable "APP_IMAGE_NAME" {
  type        = string
  description = "Name of the application docker image"
}

variable "APP_IMAGE_VERSION" {
  default     = "latest"
  type        = string
  description = "Version of the application docker image"
}

variable "APP_TOTAL_MEM" {
  default     = 1024
  type        = number
  description = "Total memory available for task definition"
}

variable "APP_TOTAL_CPU" {
  default     = 512
  type        = number
  description = "Total CPU available for task definition"
}

variable "APP_MEM" {
  default     = 512
  type        = number
  description = "Memory available for application task container"
}

variable "APP_CPU" {
  default     = 256
  type        = number
  description = "CPU available for application task container"
}

variable "APP_PORT" {
  default     = 80
  type        = number
  description = "Port on which your app container listen"
}
