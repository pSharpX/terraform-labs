locals {
    applicationId = lower(var.APPLICATION_ID)
    application_assets = "${local.applicationId}-assets"
    database_instance_name = "${local.applicationId}db"
    database_name = "${local.applicationId}db"
    application_name = "${local.applicationId}-app"
    database_sg_name = "database-sg"
    application_sg_name = "${local.application_name}-sg"
    key_name = "${var.APPLICATION_ID}-key"
    common_tags = {
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
    assets_tags = merge({Name = local.application_assets}, local.common_tags)
    database_tags = merge({Name = local.database_name}, local.common_tags)
    application_tags = merge({Name = local.application_name}, local.common_tags)
    database_sg_tags = merge({Name = local.database_sg_name}, local.common_tags)
    application_sg_tags = merge({Name = local.application_sg_name}, local.common_tags)
    key_tags = merge({Name = local.key_name}, local.common_tags)
}