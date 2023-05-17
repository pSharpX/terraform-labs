resource "digitalocean_database_db" "db_sample01" {
    cluster_id = "${digitalocean_database_cluster.pg-cluster.id}"
    name = "db_sample01"
}