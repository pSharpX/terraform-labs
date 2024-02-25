locals {
    database_instance_name = "${var.APPLICATION_ID}db"
    database_name = "${var.APPLICATION_ID}db"
    instance_name = "${var.APPLICATION_ID}-backend"
    sg_name = "allow-postgres-sg"
    instance_sg_name = "allow-ssh-sg"
    key_name = "${var.APPLICATION_ID}-key"
    common_tags = {
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
    database_tags = merge({Name = local.database_name}, local.common_tags)
    secgroup_tags = merge({Name = local.sg_name}, local.common_tags)
    instance_tags = merge({Name = local.instance_name}, local.common_tags)
    instance_sg_tags = merge({Name = local.instance_sg_name}, local.common_tags)
    key_tags = merge({Name = local.key_name}, local.common_tags)
}