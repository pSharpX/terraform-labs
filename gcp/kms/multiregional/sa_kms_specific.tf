resource "google_service_account" "kms_specific_sa" {
    project = data.google_project.onebank.project_id
    account_id = "kms-specific-sa"
    display_name = "Resource-Level Service Account"
    description = "Service Account with Resource-Level (KeyRing) Cloud KMS permission"
}

# Roles
# roles/cloudkms.admin
# roles/cloudkms.viewer
# roles/cloudkms.cryptoKeyEncrypter
# roles/cloudkms.cryptoKeyDecrypter
# roles/cloudkms.cryptoKeyEncrypterDecrypter

resource "google_kms_key_ring_iam_member" "resource_specific_viewer" {
    key_ring_id = try(local.keyring_ref.id)
    role = "roles/cloudkms.viewer"
    member = "serviceAccount:${google_service_account.kms_specific_sa.email}"
}

resource "google_kms_key_ring_iam_member" "resource_specific_encrypter" {
    key_ring_id = try(local.keyring_ref.id)
    role = "roles/cloudkms.cryptoKeyEncrypter"
    member = "serviceAccount:${google_service_account.kms_specific_sa.email}"
}

resource "google_kms_key_ring_iam_member" "resource_specific_decrypter" {
    key_ring_id = try(local.keyring_ref.id)
    role = "roles/cloudkms.cryptoKeyDecrypter"
    member = "serviceAccount:${google_service_account.kms_specific_sa.email}"
}

# resource "google_kms_key_ring_iam_member" "resource_specific_encrypter_decrypter" {
#     key_ring_id = try(local.keyring_ref.id)
#     role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
#     member = "serviceAccount:${google_service_account.kms_specific_sa.email}"
# }

resource "google_service_account_key" "resource_specific_sa_key" {
    service_account_id = google_service_account.kms_specific_sa.name
}

resource "local_file" "account_credentials" {
    content = base64decode(google_service_account_key.resource_specific_sa_key.private_key)
    filename = "./configs/kms-specific-sa.json"
}

data "google_service_account_access_token" "resource_specific" {
    target_service_account = google_service_account.kms_specific_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}