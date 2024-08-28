resource "google_storage_bucket" "default" {
    name = "${local.applicationId}-certificates"
    location = "US"
    force_destroy = true
    storage_class = "STANDARD"
    labels = local.common_tags

    versioning {
        enabled = false
    }
}

resource "google_storage_bucket_object" "server_ca_cert" {
    name = var.SERVER_CA_CERT_FILENAME
    bucket = google_storage_bucket.default.name
    content = google_sql_ssl_cert.database_certificates.server_ca_cert
}

resource "google_storage_bucket_object" "private_key" {
    name = var.PRIVATE_KEY_FILENAME
    bucket = google_storage_bucket.default.name
    content = google_sql_ssl_cert.database_certificates.private_key
}

resource "google_storage_bucket_object" "cert" {
    name = var.CERT_FILENAME
    bucket = google_storage_bucket.default.name
    content = google_sql_ssl_cert.database_certificates.cert
}

resource "google_storage_bucket_object" "truststore_dir" {
    name = "truststore/"
    bucket = google_storage_bucket.default.name
    content = " "
}

resource "google_storage_bucket_object" "trust_cert_keystore" {
    name = "truststore/${var.TRUST_CERTIFICATE_KEYSTORE_FILE}"
    bucket = google_storage_bucket.default.name
    source = local.trust_certificate_keystore_local_path

    lifecycle {
        precondition {
            condition = null_resource.create_trust_cert_keystore.id != null && fileexists(local.trust_certificate_keystore_local_path)
            error_message = "trust keystore file was not found!"
        }
    }

    depends_on = [ null_resource.create_trust_cert_keystore ]
}

resource "google_storage_bucket_object" "client_cert_keystore" {
    name = "truststore/${var.CLIENT_CERTIFICATE_KEYSTORE_FILE}"
    bucket = google_storage_bucket.default.name
    source = local.client_certificate_keystore_local_path

    lifecycle {
        precondition {
            condition = null_resource.import_client_cert_keystore.id != null && fileexists(local.client_certificate_keystore_local_path)
            error_message = "client keystore file was not found!"
        }
    }

    depends_on = [ null_resource.import_client_cert_keystore ]
}