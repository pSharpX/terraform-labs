# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# https://cloud.google.com/sql/docs/postgres/admin-api/rest/v1beta4/instances#SslMode

# SslMode
#
# ENCRYPTED_ONLY
# Only allow connections encrypted with SSL/TLS. For SSL connections to MySQL and PostgreSQL, the client certificate isn't verified.
# When this value is used, the legacy requireSsl flag must be false or cleared to avoid a conflict between the values of the two flags.
#
# TRUSTED_CLIENT_CERTIFICATE_REQUIRED
# Only allow connections encrypted with SSL/TLS and with valid client certificates.
# When this value is used, the legacy requireSsl flag must be true or cleared to avoid the conflict between values of two flags. PostgreSQL clients or users that connect using IAM database authentication must use either the Cloud SQL Auth Proxy or Cloud SQL Connectors to enforce client identity verification.
# Only applicable to MySQL and PostgreSQL. Not applicable to SQL Server.
#
# # Default is ALLOW_UNENCRYPTED_AND_ENCRYPTED

resource "google_sql_database_instance" "mysql" {
    name = "${local.instance_name}-mysql"
    database_version = "MYSQL_8_0"
    region = var.REGION
    deletion_protection = false
    encryption_key_name = data.google_kms_crypto_key.default.id
    root_password = var.DB_PASSWORD # Required to avoid issue "Root user's password is not policy compliant"

    settings {
        tier = "db-custom-4-8192"
        edition = "ENTERPRISE"
        user_labels = local.common_tags
        availability_type = "REGIONAL"
        disk_type = "PD_SSD"
        disk_size = 60
        disk_autoresize_limit = "0"
        disk_autoresize = true
        pricing_plan = "PER_USE"

        location_preference {
            zone = var.ZONE
        }

        backup_configuration {
            start_time = "04:00"
            enabled = true
            binary_log_enabled = true
            location = "us-east1"
            transaction_log_retention_days = 7

            backup_retention_settings {
                retained_backups = 10
                retention_unit = "COUNT"
            }
        }

        ip_configuration {
            ipv4_enabled = true
            require_ssl = true
            ssl_mode = "TRUSTED_CLIENT_CERTIFICATE_REQUIRED"
            authorized_networks {
                name = "allow_all_networks"
                value = "0.0.0.0/0"
            }
        }

        maintenance_window {
            day = 7
            hour = 4
            update_track = "stable"
        }

        password_validation_policy {
            min_length = 8
            complexity = "COMPLEXITY_DEFAULT"
            reuse_interval = 2
            disallow_username_substring = true
            enable_password_policy = true
        }
    }
}
