
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance

# tier - (Optional) The service tier of the instance. Must be one of these values:
#
# BASIC: standalone instance
# STANDARD_HA: highly available primary/replica instances Default value is BASIC. Possible values are: BASIC, STANDARD_HA.

resource "google_redis_instance" "default" {
    name = local.redis_instance
    display_name = "OneBank Redis Cache Instance"
    tier = "BASIC"
    memory_size_gb = 1
    region = var.REGION
    location_id = data.google_compute_zones.zones.names[0]
    labels = local.common_tags
    redis_version = "REDIS_4_0"
    auth_enabled = false
    authorized_network = data.google_compute_network.default.id
    transit_encryption_mode = "DISABLED"
    read_replicas_mode = "READ_REPLICAS_DISABLED"

    maintenance_policy {
        weekly_maintenance_window {
            day = "SUNDAY"
            start_time {
                hours = 0
                minutes = 30
                seconds = 0
                nanos = 0
            }
        }
    }
}