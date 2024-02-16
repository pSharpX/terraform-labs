locals {
    bucket_name = "${var.ENVIRONMENT}-${var.APPLICATION_ID}-storage"
    common_tags = {
        Name = local.bucket_name
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
}