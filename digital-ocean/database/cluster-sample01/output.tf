output "host" {
    value = digitalocean_database_cluster.pg-cluster.host
}

output "port" {
    value = digitalocean_database_cluster.pg-cluster.port
}

output "default_database" {
    value = digitalocean_database_cluster.pg-cluster.database
}

output "default_username" {
    value = digitalocean_database_cluster.pg-cluster.user
}