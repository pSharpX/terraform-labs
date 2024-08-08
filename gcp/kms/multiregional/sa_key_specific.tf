resource "google_service_account" "key_specific_sa" {
    project = data.google_project.onebank.project_id
    account_id = "crypto-key-specific-sa"
    display_name = "Resource-Level Service Account"
    description = "Service Account with Resource-Level (Crypto Key) Cloud KMS permission"
}

# Roles
# roles/cloudkms.admin
# roles/cloudkms.viewer
# roles/cloudkms.cryptoKeyEncrypter
# roles/cloudkms.cryptoKeyDecrypter
# roles/cloudkms.cryptoKeyEncrypterDecrypter

resource "google_kms_crypto_key_iam_member" "key_specific_encrypter" {
    crypto_key_id = try(local.crypto_key_ref.id)
    role = "roles/cloudkms.cryptoKeyEncrypter"
    member = "serviceAccount:${google_service_account.key_specific_sa.email}"
}

resource "google_kms_crypto_key_iam_member" "key_specific_decrypter" {
    crypto_key_id = try(local.crypto_key_ref.id)
    role = "roles/cloudkms.cryptoKeyDecrypter"
    member = "serviceAccount:${google_service_account.key_specific_sa.email}"
}

resource "google_service_account_key" "key_specific_sa_key" {
    service_account_id = google_service_account.key_specific_sa.name
}

resource "local_file" "key_account_credentials" {
    content = base64decode(google_service_account_key.key_specific_sa_key.private_key)
    filename = "./configs/key-specific-sa.json"
}

data "google_service_account_access_token" "key_specific" {
    target_service_account = google_service_account.key_specific_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}