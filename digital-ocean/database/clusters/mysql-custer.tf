resource "digitalocean_database_cluster" "mysql-cluster" {
    name = "mysql-cluster"
    engine = "mysql"
    version = "${lookup(var.MYSQL_VERSIONS, "latest")}"
    size = "${lookup(var.DO_DB_SIZES, var.DO_DB_DEFAULT_SIZE)}"
    region = "${lookup(var.DO_REGIONS, var.DO_DEFAULT_REGION)}"
    node_count = 1
    tags = [ "aforo255", "database", "terraform" ]
}