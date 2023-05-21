output "host" {
    value = {
        "pg-cluster": digitalocean_database_cluster.pg-cluster.host
        "mysql-cluster": digitalocean_database_cluster.mysql-cluster.host
        "mongo-cluster": digitalocean_database_cluster.mongo-cluster.host
        "redis-cluster": digitalocean_database_cluster.redis-cluster.host
    }
}

output "port" {
    value = {
        "pg-port": digitalocean_database_cluster.pg-cluster.port
        "mysql-port": digitalocean_database_cluster.mysql-cluster.port
        "mongo-port": digitalocean_database_cluster.mongo-cluster.port
        "redis-port": digitalocean_database_cluster.redis-cluster.port
    }
}

output "default_database" {
    value = {
        "pg-database-name": digitalocean_database_cluster.pg-cluster.database
        "mysql-database-name": digitalocean_database_cluster.mysql-cluster.database
        "mongo-database-name": digitalocean_database_cluster.mongo-cluster.database
        "redis-database-name": digitalocean_database_cluster.redis-cluster.database
    }
}

output "default_username" {
    value = {
        "pg-username": digitalocean_database_cluster.pg-cluster.user
        "mysql-username": digitalocean_database_cluster.mysql-cluster.user
        "mongo-username": digitalocean_database_cluster.mongo-cluster.user
        "redis-username": digitalocean_database_cluster.redis-cluster.user
    }
}