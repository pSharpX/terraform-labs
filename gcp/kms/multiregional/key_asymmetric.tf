
resource "google_kms_crypto_key" "asymmetric_key" {
    count = local.create_crypto_key
    name = local.asymmetric_crypto_key_name
    key_ring = try(local.keyring_ref.id)
    #rotation_period = "86400s"
    purpose = "ASYMMETRIC_DECRYPT"
    destroy_scheduled_duration = "86400s"
    labels = local.common_tags
    skip_initial_version_creation = true

    version_template {
        algorithm = "RSA_DECRYPT_OAEP_2048_SHA256"
        protection_level = "SOFTWARE"
    }

    lifecycle {
        #prevent_destroy = true
        ignore_changes = [ 
            destroy_scheduled_duration
         ]
    }
}

resource "google_kms_crypto_key_version" "asymmetric_primary" {
    crypto_key = try(local.asymmetric_crypto_key_ref.id)
    state = "ENABLED"
}

resource "google_kms_crypto_key_version" "asymmetric_deprecated" {
    crypto_key = try(local.asymmetric_crypto_key_ref.id)
    state = "DISABLED"
}
