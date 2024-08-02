locals {
    applicationId = lower(var.APPLICATION_ID)
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    create_keyring = var.CREATE_KMS_KEYRING ? 1: 0
    create_crypto_key = var.CREATE_KMS_KEY ? 1: 0
    keyring_name = "${local.applicationId}-keyring"
    crypto_key_name = "${local.applicationId}-symmetric-key"
    asymmetric_crypto_key_name = "${local.applicationId}-asymmetric-key"
    keyring_ref = try(data.google_kms_key_ring.default[0], google_kms_key_ring.onebank_keyring[0])
    crypto_key_ref = try(data.google_kms_crypto_key.symmetric_key[0], google_kms_crypto_key.symmetric_key[0])
    asymmetric_crypto_key_ref = try(data.google_kms_crypto_key.asymmetric_key[0], google_kms_crypto_key.asymmetric_key[0])
}