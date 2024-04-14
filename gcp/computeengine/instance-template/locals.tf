locals {
    applicationId = lower(var.APPLICATION_ID)
    instance_name = "${local.applicationId}-instance"
    instance_firewall = "${local.instance_name}-firewall"
    key_name = "${local.applicationId}-key"
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    instance_tags = merge({name = local.instance_name}, local.common_tags)
    instance_firewall_tags = merge({name = local.instance_firewall}, local.common_tags)
    key_tags = merge({name = local.key_name}, local.common_tags)
}