output "database_url" {
    value = "jdbc:postgresql://${aws_db_instance.onebank_database.address}/${local.database_name}"
}
output "application-url" {
    value = aws_elastic_beanstalk_environment.onebank_development.cname
}