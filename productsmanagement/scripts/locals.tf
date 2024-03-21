locals {
    application = lower(var.APPLICATION_ID)
    key_name = "${local.application}-key"
    instance_name = "${local.application}-instance"
    database_identifier = "${local.application}-database"
    database_name = local.application
    database_sg_name = "${local.application}-database-sg"
    instance_sg_name = "${local.application}-instance-sg"
    common_tags = {
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
    key_tags = merge({Name = local.key_name}, local.common_tags)
    instance_tags = merge({Name = local.instance_name}, local.common_tags)
    database_tags = merge({Name = local.database_identifier}, local.common_tags)
    database_sg_tags = merge({Name = local.database_sg_name}, local.common_tags)
    instance_sg_tags = merge({Name = local.instance_sg_name}, local.common_tags)
}