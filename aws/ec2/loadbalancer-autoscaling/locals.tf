locals {
    key_name = "${var.APPLICATION_ID}-key"
    elb_name = "${var.APPLICATION_ID}-loadbalancer"
    sec_group_name = "${var.APPLICATION_ID}-instance-secgroup"
    elb_secgroup_name = "${var.APPLICATION_ID}-elb-secgroup"
    common_tags = {
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
    key_tags = merge({Name = local.key_name}, local.common_tags)
    sec_groups_tags = merge({Name = local.sec_group_name}, local.common_tags)
    elb_tags = merge({Name = local.elb_name}, local.common_tags)
    elb_secgroup_tags = merge({Name = local.elb_secgroup_name}, local.common_tags)
}