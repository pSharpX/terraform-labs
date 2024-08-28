# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret

resource "google_secret_manager_secret" "db_password" {
    secret_id = "db_password"
    labels = local.common_tags

    replication {
        auto {}
    }
}

resource "google_secret_manager_secret_version" "db_password_value" {
    secret = google_secret_manager_secret.db_password.id
    secret_data = var.DB_PASSWORD
    enabled = true
}

resource "google_secret_manager_secret" "db_user" {
    secret_id = "db_user"
    labels = local.common_tags

    replication {
        auto {}
    }
}

resource "google_secret_manager_secret_version" "db_user_value" {
    secret = google_secret_manager_secret.db_user.id
    secret_data = var.DB_USER
    enabled = true
}

resource "google_secret_manager_secret" "db_name" {
    secret_id = "db_name"
    labels = local.common_tags

    replication {
        auto {}
    }
}

resource "google_secret_manager_secret_version" "db_name_value" {
    secret = google_secret_manager_secret.db_name.id
    secret_data = var.DB_NAME
    enabled = true
}

resource "google_secret_manager_secret" "datasource_url" {
    secret_id = "datasource_url"
    labels = local.common_tags

    replication {
        auto {}
    }

    depends_on = [ google_sql_database_instance.onebank_instance ]
}

# https://github.com/GoogleCloudPlatform/cloud-sql-jdbc-socket-factory/blob/main/docs/jdbc.md#postgres-1
resource "google_secret_manager_secret_version" "datasource_url_value" {
    secret = google_secret_manager_secret.datasource_url.id
    secret_data = "jdbc:postgresql:///${var.DB_NAME}?sslMode=VERIFY_CA&cloudSqlInstance=${google_sql_database_instance.onebank_instance.connection_name}&socketFactory=com.google.cloud.sql.postgres.SocketFactory"
    enabled = true

    depends_on = [ google_sql_database_instance.onebank_instance ]
}

resource "google_secret_manager_secret" "trust_cert_keystore_path" {
    secret_id = "trust_certificate_keystore_path"
    labels = local.common_tags

    replication {
        auto {}
    }
}

# https://www.baeldung.com/spring-boot-mysql-tls
resource "google_secret_manager_secret_version" "trust_cert_keystore_path_value" {
    secret = google_secret_manager_secret.trust_cert_keystore_path.id
    secret_data = local.trust_certificate_keystore_path
    enabled = true

    depends_on = [ google_storage_bucket.default ]
}

resource "google_secret_manager_secret" "trust_cert_keystore_pwd" {
    secret_id = "trust_certificate_keystore_pwd"
    labels = local.common_tags

    replication {
        auto {}
    }
}

resource "google_secret_manager_secret_version" "trust_cert_keystore_pwd_value" {
    secret = google_secret_manager_secret.trust_cert_keystore_pwd.id
    secret_data = var.TRUST_CERTIFICATE_KEYSTORE_PWD
    enabled = true

    depends_on = [ google_storage_bucket.default ]
}

resource "google_secret_manager_secret" "client_cert_keystore_path" {
    secret_id = "client_certificate_keystore_path"
    labels = local.common_tags

    replication {
        auto {}
    }
}

resource "google_secret_manager_secret_version" "client_cert_keystore_path_value" {
    secret = google_secret_manager_secret.client_cert_keystore_path.id
    secret_data = local.client_certificate_keystore_path
    enabled = true

    depends_on = [ google_storage_bucket.default ]
}

resource "google_secret_manager_secret" "client_cert_keystore_pwd" {
    secret_id = "client_certificate_keystore_pwd"
    labels = local.common_tags

    replication {
        auto {}
    }
}

resource "google_secret_manager_secret_version" "client_cert_keystore_pwd_value" {
    secret = google_secret_manager_secret.client_cert_keystore_pwd.id
    secret_data = var.CLIENT_CERTIFICATE_KEYSTORE_PWD
    enabled = true

    depends_on = [ google_storage_bucket.default ]
}
