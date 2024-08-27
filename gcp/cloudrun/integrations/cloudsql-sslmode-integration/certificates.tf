resource "google_sql_ssl_cert" "database_certificates" {
    common_name = "${local.applicationId}-client-cert"
    instance = google_sql_database_instance.onebank_instance.name
}

resource "local_sensitive_file" "server_ca_cert" {
    content = google_sql_ssl_cert.database_certificates.server_ca_cert
    filename = "./configs/${var.SERVER_CA_CERT_FILENAME}"
}

resource "local_sensitive_file" "private_key" {
    content = google_sql_ssl_cert.database_certificates.private_key
    filename = "./configs/${var.PRIVATE_KEY_FILENAME}"
}

resource "local_sensitive_file" "cert" {
    content = google_sql_ssl_cert.database_certificates.cert
    filename = "./configs/${var.CERT_FILENAME}"
}