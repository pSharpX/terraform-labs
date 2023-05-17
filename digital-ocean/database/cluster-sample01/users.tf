resource "digitalocean_database_user" "user_sample01" {
    cluster_id = digitalocean_database_cluster.pg-cluster.id
    name = "user_sample01"
}