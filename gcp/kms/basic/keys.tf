# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring
# https://cloud.google.com/kms/docs/reference/rest/v1/projects.locations.keyRings.cryptoKeys

# KeyRings cannot be deleted from Google Cloud Platform. 
# Destroying a Terraform-managed KeyRing will remove it from state but will not delete the resource from the project.#

resource "google_kms_key_ring" "onebank_keyring" {
    count = local.create_keyring
    name = local.keyring_name
    location = "global"

    # lifecycle {
    #     prevent_destroy = true
    # }
}


resource "google_kms_crypto_key" "onebank_cmek" {
    count = local.create_crypto_key
    name = local.crypto_key_name
    key_ring = try(local.keyring_ref.id)
    rotation_period = "86400s"
    purpose = "ENCRYPT_DECRYPT"
    destroy_scheduled_duration = "86400s"
    labels = local.common_tags

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

resource "google_kms_crypto_key_version" "old_version" {
    crypto_key = try(local.crypto_key_ref.id)
    state = "ENABLED"
}
