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

variable "DB_PASSWORD" {
    type = string
    description = "Password value for accessing Database"
    sensitive = true
}

variable "DB_USER" {
    type = string
    description = "Username value for accessing Database"
    sensitive = true
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

variable "SERVER_CA_CERT_FILENAME" {
    type = string
    description = "server-ca"
    default = "server-ca.pem"
}

variable "PRIVATE_KEY_FILENAME" {
    type = string
    description = "client-key"
    default = "client-key.pem"
}

variable "CERT_FILENAME" {
    type = string
    description = "client-cert"
    default = "client-cert.pem"
}

variable "TRUST_CERTIFICATE_KEYSTORE_FILE" {
    type = string
    default = "truststore.jks"
    description = "KeyStore(JKS) file the contains trust certificates for TLS"
    sensitive = true
}

variable "TRUST_CERTIFICATE_KEYSTORE_PWD" {
    type = string
    description = "Pwd to access keystore file the contains trust certificates for TLS"
    sensitive = true
}

variable "CLIENT_CERTIFICATE_KEYSTORE_FILE" {
    type = string
    default = "client-cert.jks"
    description = "KeyStore(JKS) file the contains client certificates for TLS"
    sensitive = true
}

variable "CLIENT_CERTIFICATE_KEYSTORE_PWD" {
    type = string
    description = "Pwd to access keystore file the contains client certificates for TLS"
    sensitive = true
}
