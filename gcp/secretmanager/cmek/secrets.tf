# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret
# https://cloud.google.com/secret-manager/docs/cmek
# https://cloud.google.com/secret-manager/docs/cmek#service-identity
# https://cloud.google.com/iam/docs/service-agents
# https://cloud.google.com/iam/docs/create-service-agents#grant-role-to-service-agent-terraform

resource "google_kms_crypto_key_iam_member" "encrypter_decrypter_binding" {
    for_each = local.crypto_keys
    crypto_key_id = each.value.id
    role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
    member = "serviceAccount:service-${data.google_project.onebank.number}@gcp-sa-secretmanager.iam.gserviceaccount.com"
}

resource "google_secret_manager_secret" "db_password" {
    secret_id = "db_password"
    labels = local.common_tags

    replication {
        auto {
            customer_managed_encryption {
                kms_key_name = data.google_kms_crypto_key.global_key.id
            }
        }
    }

    depends_on = [
        google_kms_crypto_key_iam_member.encrypter_decrypter_binding
    ]
}

resource "google_secret_manager_secret_version" "db_password_v1" {
    secret = google_secret_manager_secret.db_password.id
    secret_data = var.DB_PASSWORD
    enabled = true
}

resource "google_secret_manager_secret" "db_user" {
    secret_id = "db_user"
    labels = local.common_tags

    replication {
        user_managed {
            replicas {
                location = data.google_kms_key_ring.regional_keyring.location
                customer_managed_encryption {
                    kms_key_name = data.google_kms_crypto_key.regional_key.id
                }
            }
        }
    }

    depends_on = [ 
        google_kms_crypto_key_iam_member.encrypter_decrypter_binding
     ]
}

resource "google_secret_manager_secret_version" "db_user_v1" {
    secret = google_secret_manager_secret.db_user.id
    secret_data = var.DB_USER
    enabled = true
}
