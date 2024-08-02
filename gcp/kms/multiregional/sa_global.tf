resource "google_service_account" "global_kms_sa" {
    project = data.google_project.onebank.project_id
    account_id = "global-kms-sa"
    display_name = "Global KMS Service Account"
    description = "Global Service Account for Cloud KMS Access"
}

# Roles
# roles/cloudkms.admin
# roles/cloudkms.viewer
# roles/cloudkms.cryptoKeyEncrypter
# roles/cloudkms.cryptoKeyDecrypter
# roles/cloudkms.cryptoKeyEncrypterDecrypter

resource "google_project_iam_member" "viewer" {
    project = data.google_project.onebank.project_id
    role = "roles/cloudkms.viewer"
    member = "serviceAccount:${google_service_account.global_kms_sa.email}"
}

resource "google_project_iam_member" "encrypter" {
    project = data.google_project.onebank.project_id
    role = "roles/cloudkms.cryptoKeyEncrypter"
    member = "serviceAccount:${google_service_account.global_kms_sa.email}"
}

resource "google_project_iam_member" "decrypter" {
    project = data.google_project.onebank.project_id
    role = "roles/cloudkms.cryptoKeyDecrypter"
    member = "serviceAccount:${google_service_account.global_kms_sa.email}"
}

# resource "google_project_iam_member" "encrypter_decrypter" {
#     project = data.google_project.onebank.project_id
#     role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
#     member = "serviceAccount:${google_service_account.global_kms_sa.email}"
# }

resource "google_service_account_key" "global_kms_sa_key" {
    service_account_id = google_service_account.global_kms_sa.name
}

resource "local_file" "global_account_credentials" {
    content = base64decode(google_service_account_key.global_kms_sa_key.private_key)
    filename = "./configs/global-kms-sa.json"
}

data "google_service_account_access_token" "global" {
    target_service_account = google_service_account.global_kms_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}
