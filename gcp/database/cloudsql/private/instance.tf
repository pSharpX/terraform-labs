# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance

resource "google_sql_database_instance" "db_instance" {
    name = local.instance_name
    database_version = "MYSQL_8_0"
    region = var.REGION
    deletion_protection = false

    settings {
        tier = "db-n1-standard-1"
        edition = "ENTERPRISE"
        user_labels = local.common_tags
        availability_type = "REGIONAL"
        disk_type = "PD_SSD"
        pricing_plan = "PER_USE"

        location_preference {
            zone = var.ZONE
        }

        ip_configuration {
            ipv4_enabled = false
            private_network = data.google_compute_network.default.self_link
        }

        backup_configuration {
            enabled = true
            binary_log_enabled = true
        }
    }

    depends_on = [ google_service_networking_connection.private_vpc_connection ]
}