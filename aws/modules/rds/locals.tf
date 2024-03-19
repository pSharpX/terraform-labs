locals {
    rds_name = "${lower(var.APPLICATION_ID)}-database"
    database_name = "${lower(var.APPLICATION_ID)}"
    common_tags = {
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
    rds_tags = merge({Name = local.rds_name}, local.common_tags)
}