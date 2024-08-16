# https://cloud.google.com/sql/docs/mysql/configure-cmek#service-account

resource "google_project_service_identity" "cloud_sql_identity" {
    provider = google-beta
    service = "sqladmin.googleapis.com"
}

resource "google_kms_crypto_key_iam_member" "encrypter_decrypter_binding" {
    crypto_key_id = data.google_kms_crypto_key.default.id
    role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
    # member = "serviceAccount:service-${data.google_project.onebank.number}@gcp-sa-cloud-sql.iam.gserviceaccount.com"
    member = "serviceAccount:${google_project_service_identity.cloud_sql_identity.email}"
}