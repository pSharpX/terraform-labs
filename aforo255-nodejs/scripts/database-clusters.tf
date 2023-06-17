resource "digitalocean_database_cluster" "mongo-cluster" {
    name = "mongo-cluster"
    engine = "mongodb"
    version = "${lookup(var.MONGO_VERSIONS, "latest")}"
    size = "${lookup(var.DO_DB_SIZES, var.DO_DB_DEFAULT_SIZE)}"
    region = "${lookup(var.DO_REGIONS, var.DO_DEFAULT_REGION)}"
    node_count = 1
    tags = [ "aforo255", "database", "terraform" ]
}

resource "digitalocean_database_cluster" "mysql-cluster" {
    name = "mysql-cluster"
    engine = "mysql"
    version = "${lookup(var.MYSQL_VERSIONS, "latest")}"
    size = "${lookup(var.DO_DB_SIZES, var.DO_DB_DEFAULT_SIZE)}"
    region = "${lookup(var.DO_REGIONS, var.DO_DEFAULT_REGION)}"
    node_count = 1
    tags = [ "aforo255", "database", "terraform" ]
}

resource "digitalocean_database_cluster" "pg-cluster" {
    name = "pg-cluster"
    engine = "pg"
    version = "${lookup(var.PG_VERSIONS, "latest")}"
    size = "${lookup(var.DO_DB_SIZES, var.DO_DB_DEFAULT_SIZE)}"
    region = "${lookup(var.DO_REGIONS, var.DO_DEFAULT_REGION)}"
    node_count = 1
    tags = [ "aforo255", "database", "terraform" ]
}

resource "digitalocean_database_cluster" "redis-cluster" {
    name = "redis-cluster"
    engine = "redis"
    version = "${lookup(var.REDIS_VERSIONS, "latest")}"
    size = "${lookup(var.DO_DB_SIZES, var.DO_DB_DEFAULT_SIZE)}"
    region = "${lookup(var.DO_REGIONS, var.DO_DEFAULT_REGION)}"
    node_count = 1
    tags = [ "aforo255", "database", "cache", "terraform" ]
}