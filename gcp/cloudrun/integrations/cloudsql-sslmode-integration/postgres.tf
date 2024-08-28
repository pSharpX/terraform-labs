# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance

resource "google_sql_database_instance" "onebank_instance" {
    name = local.instance_name
    database_version = "POSTGRES_15"
    region = var.REGION
    deletion_protection = false
    root_password = var.DB_PASSWORD

    settings {
        tier = "db-custom-4-8192"
        edition = "ENTERPRISE"
        user_labels = local.common_tags
        availability_type = "ZONAL"
        disk_type = "PD_SSD"
        pricing_plan = "PER_USE"

        database_flags {
            name = "cloudsql.iam_authentication"
            value = "off"
        }

        location_preference {
            zone = var.ZONE
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
    }
}