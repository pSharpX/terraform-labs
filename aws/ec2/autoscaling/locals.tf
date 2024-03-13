locals {
    key_name = "${var.APPLICATION_ID}-key"
    sec_group_name = "${var.APPLICATION_ID}-instance-secgroup"
    common_tags = {
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
    key_tags = merge({Name = local.key_name}, local.common_tags)
    sec_groups_tags = merge({Name = local.sec_group_name}, local.common_tags)
}