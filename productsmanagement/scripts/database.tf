resource "aws_db_parameter_group" "db_parameters" {
    name = "onebank-db-parameters"
    family = data.aws_rds_engine_version.db_engine.parameter_group_family
    description = "Database parameter group"
    tags = local.common_tags

    parameter {
        name = "log_connections"
        value = "1"
    }   
}

resource "aws_db_subnet_group" "db_subnet" {
    name = "onebank-db-subnet"
    description = "RDS subnet group"
    subnet_ids = [ data.aws_subnet.main_private_1.id, data.aws_subnet.main_private_2.id ]
    tags = local.common_tags
}

resource "aws_db_instance" "database" {
    db_name = local.database_name
    identifier = local.database_identifier
    allocated_storage = 20
    instance_class = "db.t3.micro"
    engine = data.aws_rds_engine_version.db_engine.engine
    engine_version = data.aws_rds_engine_version.db_engine.version
    username = var.DB_USERNAME
    password = var.DB_PASSWORD
    storage_type = "gp2"
    backup_retention_period = 7
    multi_az = false
    skip_final_snapshot = true
    publicly_accessible = false
    availability_zone = data.aws_subnet.main_private_1.availability_zone
    parameter_group_name = aws_db_parameter_group.db_parameters.name
    db_subnet_group_name = aws_db_subnet_group.db_subnet.name
    vpc_security_group_ids = [ aws_security_group.database_sg.id ]
    tags = local.database_tags
}