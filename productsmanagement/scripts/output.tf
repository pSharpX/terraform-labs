output "db-endpoint" {
    value = aws_db_instance.database.endpoint
}

output "psql-cli" {
    value = "psql -h ${aws_db_instance.database.address} -p ${aws_db_instance.database.port} -d ${aws_db_instance.database.db_name} -U ${aws_db_instance.database.username} -W"
}

output "connection-string" {
    sensitive = true
    value = "jdbc:postgresql://${aws_db_instance.database.username}:${aws_db_instance.database.password}@${aws_db_instance.database.endpoint}:${aws_db_instance.database.port}/${aws_db_instance.database.db_name}"
}

output "instance-ip" {
    value = aws_instance.instance.public_ip
}

output "instance-ssh" {
    value = "ssh -i ${var.PATH_TO_PRIVATE_KEY} ubuntu@${aws_instance.instance.public_ip}"
}