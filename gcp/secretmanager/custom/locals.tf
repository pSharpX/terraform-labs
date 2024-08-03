locals {
    applicationId = lower(var.APPLICATION_ID)
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    expire_time = timeadd(timestamp(), "744h")
    # Version destroy TTL must be at least [24h]
    version_destroy_ttl = "${3600*24}s"
    rotation_period = 3600*24*7
    next_rotation_time = timeadd(timestamp(), "168h")
}