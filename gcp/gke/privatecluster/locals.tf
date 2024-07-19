locals {
    applicationId = lower(var.APPLICATION_ID)
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    zones = data.google_compute_zones.locations.names
    single_zone = element(data.google_compute_zones.locations.names, 0)
    zonal_cluster_zones = setsubtract(local.zones, [local.single_zone])
}