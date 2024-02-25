locals {
    database_instance_name = "${var.APPLICATION_ID}db"
    database_name = "${var.APPLICATION_ID}db"
    sg_name = "allow-postgres-sg"
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
    instance_tags = merge({Name = "${var.APPLICATION_ID}-backend"}, local.common_tags)
    key_tags = merge({Name = local.key_name}, local.common_tags)
}