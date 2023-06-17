output "pg_cluster" {
    value = {
        "pg-cluster": digitalocean_database_cluster.pg-cluster.host
        "pg-port": digitalocean_database_cluster.pg-cluster.port
        "pg-database-name": digitalocean_database_cluster.pg-cluster.database
        "pg-username": digitalocean_database_cluster.pg-cluster.user
    }
}

output "mysql_cluster" {
    value = {
        "mysql-cluster": digitalocean_database_cluster.mysql-cluster.host
        "mysql-port": digitalocean_database_cluster.mysql-cluster.port
        "mysql-database-name": digitalocean_database_cluster.mysql-cluster.database
        "mysql-username": digitalocean_database_cluster.mysql-cluster.user
    }
}

output "mongo_cluster" {
    value = {
        "mongo-cluster": digitalocean_database_cluster.mongo-cluster.host
        "mongo-port": digitalocean_database_cluster.mongo-cluster.port
        "mongo-database-name": digitalocean_database_cluster.mongo-cluster.database
        "mongo-username": digitalocean_database_cluster.mongo-cluster.user
    }
}

output "redis_cluster" {
    value = {
        "redis-cluster": digitalocean_database_cluster.redis-cluster.host
        "redis-port": digitalocean_database_cluster.redis-cluster.port        
        "redis-database-name": digitalocean_database_cluster.redis-cluster.database
        "redis-username": digitalocean_database_cluster.redis-cluster.user
    }
}