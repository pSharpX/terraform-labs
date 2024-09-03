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

variable "REPOSITORY_NAME" {
    default = "onebank-docker"
    type = string
    description = "Repository where docker images are located"
}

variable "DB_NAME" {
    type = string
    description = "Database name"
    sensitive = true
}

variable "DATASOURCE_URL" {
    type = string
    default = "jdbc:postgresql://localhost:5432/<database_name>"
    description = "URL for accessing database"
    sensitive = true
}

variable "APP_CONFIGURATIONS" {
    type = map(string)
    description = "Map containig key-value pair configurations for application"
    default = {
        "SPRING_PROFILES_ACTIVE" = "dev"
        "CONTROL_PLANE_DATABASE_ENABLED" = "true"  
        "SPRING_DATASOURCE_DRIVER_CLASS_NAME" = "org.postgresql.Driver"
        "SPRING_JPA_HIBERNATE_DDL_AUTO" = "update"
    }
}