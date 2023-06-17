resource "digitalocean_database_db" "DB_SECURITY" {
    cluster_id = "${digitalocean_database_cluster.mysql-cluster.id}"
    name = "DB_SECURITY"
}

resource "digitalocean_database_db" "DB_OPERATION" {
    cluster_id = "${digitalocean_database_cluster.mysql-cluster.id}"
    name = "DB_OPERATION"
}

resource "digitalocean_database_db" "DB_INVOICE" {
    cluster_id = "${digitalocean_database_cluster.pg-cluster.id}"
    name = "DB_INVOICE"
}

resource "digitalocean_database_db" "DB_TRANSACTION" {
    cluster_id = "${digitalocean_database_cluster.mongo-cluster.id}"
    name = "DB_TRANSACTION"
}