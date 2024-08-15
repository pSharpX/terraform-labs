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
        availability_type = "ZONAL"
        disk_type = "PD_HDD" # PD_SSD
        pricing_plan = "PER_USE"

        location_preference {
            zone = var.ZONE
        }

        ip_configuration {
            ipv4_enabled = true
        }
    }
}