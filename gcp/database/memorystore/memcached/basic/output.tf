output "project_number" {
    value = data.google_project.onebank.number
}

output "discovery_endpoint" {
    value = google_memcache_instance.default.discovery_endpoint
}

output "nodes" {
    value = [ for node in google_memcache_instance.default.memcache_nodes : {
        node_id = node.node_id
        zone = node.zone
        port = node.port
        host = node.host
        state = node.state
    }]
}

output "memcached_version" {
    value = google_memcache_instance.default.memcache_full_version
}