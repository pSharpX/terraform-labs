# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance

resource "google_sql_database_instance" "db_instance" {
    name = local.instance_name
    database_version = "POSTGRES_15"
    region = var.REGION
    deletion_protection = false

    settings {
        tier = "db-custom-4-8192"
        edition = "ENTERPRISE"
        user_labels = local.common_tags
        availability_type = "REGIONAL"
        disk_type = "PD_HDD" # PD_SSD
        disk_size = 40
        disk_autoresize_limit = "0"
        disk_autoresize = true
        pricing_plan = "PER_USE"

        location_preference {
            zone = var.ZONE
        }

        ip_configuration {
            ipv4_enabled = true
            authorized_networks {
                name = "allow_all_networks"
                value = "0.0.0.0/0"
            }
        }

        password_validation_policy {
            min_length = 8
            complexity = "COMPLEXITY_DEFAULT"
            reuse_interval = 2
            password_change_interval = "604800s"
            disallow_username_substring = true
            enable_password_policy = true
        }
    }
}