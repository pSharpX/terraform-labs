locals {
    cluster_type = "fg"
    cluster_name = "${var.CLUSTER_NAME}-${var.ENVIRONMENT}-${local.cluster_type}-ecs"
    common_tags = {
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
    cluster_tags = merge({Name = local.cluster_name}, local.common_tags)
}