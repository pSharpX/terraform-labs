resource "aws_db_parameter_group" "onebank-db-parameters" {
    name = "onebank-db-parameters"
    family = data.aws_rds_engine_version.postgres-engine.parameter_group_family
    description = "PostgreSQL parameter group"
    tags = local.common_tags

    parameter {
        name = "log_connections"
        value = "1"
    }
}

resource "aws_db_subnet_group" "onebank-db-subnet" {
    name = "onebank-db-subnet"
    description = "RDS subnet group"
    subnet_ids = [ data.aws_subnet.main-private-1.id, data.aws_subnet.main-private-2.id ]
    tags = local.common_tags
}

resource "aws_db_instance" "onebank-database" {
    db_name = local.database_name
    identifier = local.database_instance_name
    allocated_storage = 20
    instance_class = "db.t3.micro"
    engine = data.aws_rds_engine_version.postgres-engine.engine
    engine_version = data.aws_rds_engine_version.postgres-engine.version
    username = var.DB_USERNAME
    password = var.DB_PASSWORD
    storage_type = "gp2"
    backup_retention_period = 7
    multi_az = false
    skip_final_snapshot = true
    availability_zone = data.aws_subnet.main-private-1.availability_zone
    parameter_group_name = aws_db_parameter_group.onebank-db-parameters.name
    db_subnet_group_name = aws_db_subnet_group.onebank-db-subnet.name
    vpc_security_group_ids = [ aws_security_group.allow-postgres-sg.id ]
    tags = local.database_tags
}