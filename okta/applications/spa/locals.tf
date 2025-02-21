locals {
    applicationId = lower(var.APPLICATION_ID)
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    authorization_server = "${local.applicationId}-auth-server"
    rabbitmq_application = "${local.applicationId}-rabbitmq-spa"
    taskmaster_application = "${local.applicationId}-taskmaster-web"
 }