
resource "google_kms_crypto_key" "symmetric_key" {
    count = local.create_crypto_key
    name = local.crypto_key_name
    key_ring = try(local.keyring_ref.id)
    rotation_period = "86400s"
    purpose = "ENCRYPT_DECRYPT"
    destroy_scheduled_duration = "86400s"
    labels = local.common_tags
    skip_initial_version_creation = true

    version_template {
        algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
        protection_level = "SOFTWARE"
    }

    lifecycle {
        #prevent_destroy = true
        ignore_changes = [ 
            rotation_period,
            destroy_scheduled_duration
         ]
    }
}

resource "google_kms_crypto_key_version" "primary" {
    crypto_key = try(local.crypto_key_ref.id)
    state = "ENABLED"
}

resource "google_kms_crypto_key_version" "deprecated" {
    crypto_key = try(local.crypto_key_ref.id)
    state = "DISABLED"
}
