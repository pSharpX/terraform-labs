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
    instance_name = "${local.applicationId}-db-instance"
    trust_certificate_keystore_path = "file:/onebank_certificates/${google_storage_bucket_object.truststore_dir.name}${var.TRUST_CERTIFICATE_KEYSTORE_FILE}"
    client_certificate_keystore_path = "file:/onebank_certificates/${google_storage_bucket_object.truststore_dir.name}${var.CLIENT_CERTIFICATE_KEYSTORE_FILE}"
    trust_certificate_keystore_local_path = "./configs/${var.TRUST_CERTIFICATE_KEYSTORE_FILE}"
    client_certificate_keystore_local_path = "./configs/${var.CLIENT_CERTIFICATE_KEYSTORE_FILE}"
    p12_local_file = "./configs/certificate.p12"
 }