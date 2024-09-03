# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/memcache_instance
# https://cloud.google.com/memorystore/docs/memcached/memcached-overview
# https://cloud.google.com/memorystore/docs/memcached/memcached-overview#key_concepts

# Authorized VPC Network designates which Google VPC network your instance uses. 
# The authorized network is set during instance creation, and cannot be altered later. 
# A private services access connection must be established on a VPC network in order for it to work with Memorystore for Memcached. 
# Only resources and users who have access to the Authorized VPC network can access the instance.

resource "google_memcache_instance" "default" {
    name = local.memcached_instance
    display_name = "Onebank In-Memory Cache System"
    region = var.REGION
    zones = data.google_compute_zones.zones.names
    labels = local.common_tags
    node_count = 2
    memcache_version = "MEMCACHE_1_6_15"
    authorized_network = data.google_compute_network.default.id

    node_config {
        cpu_count = 1
        memory_size_mb = 1024
    }

    maintenance_policy {
        weekly_maintenance_window {
            day = "SUNDAY"
            duration = "14400s"
            start_time {
                hours = 0
                minutes = 30
                seconds = 0
                nanos = 0
            }
        }
    }
}