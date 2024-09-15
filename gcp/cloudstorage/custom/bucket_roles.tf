# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account

data "google_storage_project_service_account" "gcs_acount" { 
}

resource "google_kms_crypto_key_iam_member" "encrypter_decrypter_binding" {
    crypto_key_id = data.google_kms_crypto_key.default.id
    role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
    member = "serviceAccount:${data.google_storage_project_service_account.gcs_acount.email_address}"
}