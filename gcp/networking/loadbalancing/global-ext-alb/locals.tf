locals {
    applicationId = lower(var.APPLICATION_ID)
    instance_name = "${local.applicationId}-instance"
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    instance_tags = merge({name = local.instance_name}, local.common_tags)
}