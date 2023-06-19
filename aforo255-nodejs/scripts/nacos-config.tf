resource "local_file" "nacos_config" {
    content = templatefile(var.PATH_NACOS_CONFIG, {
        droplet_ipv4_address = "${digitalocean_droplet.droplet-docker-server.ipv4_address}"
        db_pg_host = "${digitalocean_database_cluster.pg-cluster.host}"
        db_pg_port = "${digitalocean_database_cluster.pg-cluster.port}"
        db_pg_username = "${digitalocean_database_user.aforo_pg_user.name}"
        db_pg_password = "${digitalocean_database_user.aforo_pg_user.password}"
        db_mysql_host = "${digitalocean_database_cluster.mysql-cluster.host}"
        db_mysql_port = "${digitalocean_database_cluster.mysql-cluster.port}"
        db_mysql_username = "${digitalocean_database_user.aforo_mysql_user.name}"
        db_mysql_password = "${digitalocean_database_user.aforo_mysql_user.password}"
        db_mongo_host = "${digitalocean_database_cluster.mongo-cluster.host}"
        db_mongo_port = "${digitalocean_database_cluster.mongo-cluster.port}"
        db_mongo_cluster = "${digitalocean_database_cluster.mongo-cluster.name}"
        db_mongo_username = "${digitalocean_database_user.aforo_mongo_user.name}"
        db_mongo_password = "${digitalocean_database_user.aforo_mongo_user.password}"
        db_redis_host = "${digitalocean_database_cluster.redis-cluster.host}"
        db_redis_port = "${digitalocean_database_cluster.redis-cluster.port}"
    })
    filename = "./configs/nacos_config.json"
}