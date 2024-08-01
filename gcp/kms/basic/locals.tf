locals {
    applicationId = lower(var.APPLICATION_ID)
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    keyring_name = "${local.applicationId}-keyring-v2"
    crypto_key_name = "${local.applicationId}-main-cmek"
    create_keyring = var.CREATE_KMS_KEYRING ? 1: 0
    create_crypto_key = var.CREATE_KMS_KEY ? 1: 0
    keyring_ref = try(data.google_kms_key_ring.default[0], google_kms_key_ring.onebank_keyring[0])
    crypto_key_ref = try(data.google_kms_crypto_key.default[0], google_kms_crypto_key.onebank_cmek[0])
}