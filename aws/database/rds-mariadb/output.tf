output "db-host" {
    value = aws_db_instance.onebank-database.endpoint
}

output "db-username" {
    value = aws_db_instance.onebank-database.username
}

output "db-password" {
    sensitive = true
    value = aws_db_instance.onebank-database.password
}