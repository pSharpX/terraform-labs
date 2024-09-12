data "google_project" "onebank" {
    project_id = var.PROJECT_ID
}

data "google_kms_key_ring" "default" {
    name = var.KEYRING_NAME
    location = var.REGION
}

data "google_kms_crypto_key" "default" {
    name = var.CMEK_NAME
    key_ring = data.google_kms_key_ring.default.id
}

data "google_storage_project_service_account" "gcs_acount" { 
}