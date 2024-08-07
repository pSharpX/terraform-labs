data "google_project" "onebank" {
    project_id = var.PROJECT_ID
}

data "google_kms_key_ring" "regional_keyring" {
    name = var.REGIONAL_KEYRING_ID
    location = var.REGION
}

data "google_kms_crypto_key" "regional_key" {
    name = var.REGIONAL_CMEK_ID
    key_ring = data.google_kms_key_ring.regional_keyring.id
}

data "google_kms_key_ring" "global_keyring" {
    name = var.GLOBAL_KEYRING_ID
    location = "global"
}

data "google_kms_crypto_key" "global_key" {
    name = var.GLOBAL_CMEK_ID
    key_ring = data.google_kms_key_ring.global_keyring.id
}