resource "digitalocean_database_user" "aforo_pg_user" {
    cluster_id = digitalocean_database_cluster.pg-cluster.id
    name = "aforo255-user"
}

resource "digitalocean_database_user" "aforo_mysql_user" {
    cluster_id = digitalocean_database_cluster.mysql-cluster.id
    name = "aforo255-user"
}

resource "digitalocean_database_user" "aforo_mongo_user" {
    cluster_id = digitalocean_database_cluster.mongo-cluster.id
    name = "aforo255-user"
}