locals {
    table_name = "${var.APPLICATION_ID}-${var.TABLE_NAME}-table"
    common_tags = {
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
    table_tags = merge({Name = local.table_name}, local.common_tags)
    metadata = base64encode(jsonencode({ 
        MetadataID = "1000X"
        InvoiceID = "100"
        InvoiceDetails = "100"
    }))
}