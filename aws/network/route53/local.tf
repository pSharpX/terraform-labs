locals {
    zone_name = "${var.APPLICATION_ID}.academy"
    backend_record = "${var.ENVIRONMENT}.api.${local.zone_name}"
    frontend_record = "${var.ENVIRONMENT}.${local.zone_name}"
    common_tags = {
        Name = local.zone_name
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
}