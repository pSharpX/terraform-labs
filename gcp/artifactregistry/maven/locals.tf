locals {
    applicationId = lower(var.APPLICATION_ID)
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    repository_name = "${local.applicationId}-maven"
    remote_upstream = "${local.applicationId}-remote-upstream"
    snapshot_upstream = "${local.applicationId}-snapshot-upstream"
    release_upstream = "${local.applicationId}-release-upstream"
}