data "google_project" "onebank" {
    project_id = var.PROJECT_ID
}

data "google_kms_key_ring" "default" {
    count = var.CREATE_KMS_KEYRING ? 0: 1
    name = local.keyring_name
    location = "global"
}

data "google_kms_crypto_key" "symmetric_key" {
    count = var.CREATE_KMS_KEY ? 0: 1
    name = local.crypto_key_name
    key_ring = try(local.keyring_ref.id)
}

data "google_kms_crypto_key" "asymmetric_key" {
    count = var.CREATE_KMS_KEY ? 0: 1
    name = local.asymmetric_crypto_key_name
    key_ring = try(local.keyring_ref.id)
}
