output "db-host" {
    value = aws_db_instance.onebank-database.endpoint
}

output "db-name" {
    value = aws_db_instance.onebank-database.db_name
}

output "db-username" {
    value = aws_db_instance.onebank-database.username
}

output "db-password" {
    sensitive = true
    value = aws_db_instance.onebank-database.password
}

output "db-engine" {
    value = {
        "engine" = data.aws_rds_engine_version.mariadb-engine.engine
        "description" = data.aws_rds_engine_version.mariadb-engine.engine_description
        "version" = data.aws_rds_engine_version.mariadb-engine.version
        "latest" = data.aws_rds_engine_version.mariadb-engine.latest
        "status" = data.aws_rds_engine_version.mariadb-engine.status
    }
}
