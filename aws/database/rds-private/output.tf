output "db-endpoint" {
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
    value = "psql -h ${aws_db_instance.onebank-database.address} -p ${aws_db_instance.onebank-database.port} -d ${aws_db_instance.onebank-database.db_name} -U ${aws_db_instance.onebank-database.username} -W"
}

output "connection-string" {
    sensitive = true
    value = "jdbc:postgresql://${aws_db_instance.onebank-database.username}:${aws_db_instance.onebank-database.password}@${aws_db_instance.onebank-database.endpoint}:${aws_db_instance.onebank-database.port}/${aws_db_instance.onebank-database.db_name}"
}

output "db-engine" {
    value = {
        "engine" = data.aws_rds_engine_version.db-engine.engine
        "description" = data.aws_rds_engine_version.db-engine.engine_description
        "version" = data.aws_rds_engine_version.db-engine.version
        "latest" = data.aws_rds_engine_version.db-engine.latest
        "status" = data.aws_rds_engine_version.db-engine.status
    }
}

output "ssh-backend" {
    value = "ssh -i ${var.PATH_TO_PRIVATE_KEY} ubuntu@${aws_instance.onebank-backend.public_ip}"
}
