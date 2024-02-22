locals {
    vpc_name = "${lower(var.APPLICATION_ID)}-vpc"
    common_tags = {
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
    vpc_tags = merge({Name = local.vpc_name}, local.common_tags)
}