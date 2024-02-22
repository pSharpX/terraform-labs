locals {
    database_instance_name = "${var.APPLICATION_ID}db"
    database_name = "${var.APPLICATION_ID}db"
    sg_name = "allow-mariadb-sg"
    common_tags = {
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
    database_tags = merge({Name = local.database_name}, local.common_tags)
    secgroup_tags = merge({Name = local.sg_name}, local.common_tags)
}