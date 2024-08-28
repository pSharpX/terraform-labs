locals {
    applicationId = lower(var.APPLICATION_ID)
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    repository_url = "${data.google_artifact_registry_repository.default.location}-docker.pkg.dev/${data.google_project.onebank.project_id}/${data.google_artifact_registry_repository.default.name}"
    control_plane = "${local.applicationId}-controlplane"
    control_plane_last_revision = "${local.control_plane}-v1"
    configs_bucket = "${local.applicationId}-configs"
    assets_bucket = "${local.applicationId}-assets"
 }