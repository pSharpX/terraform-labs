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

resource "null_resource" "create_trust_cert_keystore" {
    lifecycle {
        precondition {
            condition = !fileexists(local.trust_certificate_keystore_local_path)
            error_message = "Trust keystore file already exist. Delete the existing one before continue."
        }
    }
    provisioner "local-exec" {
        command = "keytool -importcert -alias MySQLCACert.jks -file ./configs/server-ca.pem -keystore ${local.trust_certificate_keystore_local_path} -storepass ${var.TRUST_CERTIFICATE_KEYSTORE_PWD} -noprompt"
    }

    depends_on = [ local_sensitive_file.server_ca_cert ]
}

resource "null_resource" "create_client_certificates" {
    lifecycle {
        precondition {
            condition = !fileexists(local.p12_local_file)
            error_message = "p12 file already exist. Delete the existing one before continue."
        }
    }
    provisioner "local-exec" {
        command = "openssl pkcs12 -export -in ./configs/client-cert.pem -inkey ./configs/client-key.pem -out ${local.p12_local_file} -name 'certificate' -password pass:${var.CLIENT_CERTIFICATE_KEYSTORE_PWD}"
    }

    depends_on = [ 
        local_sensitive_file.private_key,
        local_sensitive_file.cert
    ]
}

resource "null_resource" "import_client_cert_keystore" {
    lifecycle {
        precondition {
            condition = !fileexists(local.client_certificate_keystore_local_path)
            error_message = "Client keystore file already exist. Delete the existing one before continue."
        }
    }
    provisioner "local-exec" {
        command = "keytool -importkeystore -srckeystore ${local.p12_local_file} -srcstoretype pkcs12 -destkeystore ${local.client_certificate_keystore_local_path} -srcstorepass ${var.CLIENT_CERTIFICATE_KEYSTORE_PWD} -deststorepass ${var.CLIENT_CERTIFICATE_KEYSTORE_PWD} -destkeypass ${var.CLIENT_CERTIFICATE_KEYSTORE_PWD} -noprompt"
    }

    depends_on = [ null_resource.create_client_certificates ]
}
