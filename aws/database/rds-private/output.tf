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

output "psql-cli" {
    value = "psql -h ${aws_db_instance.onebank-database.endpoint} -d ${aws_db_instance.onebank-database.db_name} -U ${aws_db_instance.onebank-database.username} -W"
}

output "connection-string" {
    sensitive = true
    value = "jdbc:postgresql://${aws_db_instance.onebank-database.username}:${aws_db_instance.onebank-database.password}@${aws_db_instance.onebank-database.endpoint}:${aws_db_instance.onebank-database.port}/${aws_db_instance.onebank-database.db_name}"
}

output "db-engine" {
    value = {
        "engine" = data.aws_rds_engine_version.postgres-engine.engine
        "description" = data.aws_rds_engine_version.postgres-engine.engine_description
        "version" = data.aws_rds_engine_version.postgres-engine.version
        "latest" = data.aws_rds_engine_version.postgres-engine.latest
        "status" = data.aws_rds_engine_version.postgres-engine.status
    }
}

output "ssh-backend" {
    value = "ssh -i ${var.PATH_TO_PRIVATE_KEY} ubuntu@${aws_instance.onebank-backend.public_ip}"
}
