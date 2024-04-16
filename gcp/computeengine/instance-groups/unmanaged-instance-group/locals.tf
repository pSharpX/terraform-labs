locals {
    applicationId = lower(var.APPLICATION_ID)
    base_instance_name = "${local.applicationId}-instance"
    instance_group_name = "${local.applicationId}-backend-group"
    instance_firewall = "${local.base_instance_name}-firewall"
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    instance_tags = merge({name = local.base_instance_name}, local.common_tags)
    instance_group_tags = merge({name = local.instance_group_name}, local.common_tags)
    instance_firewall_tags = merge({name = local.instance_firewall}, local.common_tags)
}