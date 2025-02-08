locals {
    applicationId = lower(var.APPLICATION_ID)
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    resource_server_name = "${lower(var.RESOURCE_SERVER_NAME)}-${lower(var.ENVIRONMENT)}"
    client_application_name = "${lower(var.APPLICATION_NAME)}-${lower(var.ENVIRONMENT)}"
 }