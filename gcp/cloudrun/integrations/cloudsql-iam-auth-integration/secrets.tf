# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret

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
    secret_data = "jdbc:postgresql:///${var.DB_NAME}?cloudSqlInstance=${google_sql_database_instance.onebank_instance.connection_name}&socketFactory=com.google.cloud.sql.postgres.SocketFactory&user=${local.username}&enableIamAuth=true&sslmode=disable"
    enabled = true

    depends_on = [ google_sql_database_instance.onebank_instance ]
}

