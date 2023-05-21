resource "digitalocean_database_cluster" "redis-cluster" {
    name = "redis-cluster"
    engine = "redis"
    version = "${lookup(var.REDIS_VERSIONS, "latest")}"
    size = "${lookup(var.DO_DB_SIZES, var.DO_DB_DEFAULT_SIZE)}"
    region = "${lookup(var.DO_REGIONS, var.DO_DEFAULT_REGION)}"
    node_count = 1
    tags = [ "aforo255", "database", "cache", "terraform" ]
}