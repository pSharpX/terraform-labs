resource "aws_db_parameter_group" "onebank-db-parameters" {
    name = "onebank-db-parameters"
    family = "mariadb10.11"
    description = "MariaDB parameter group"
    tags = local.common_tags

    parameter {
        name = "max_allowed_packet"
        value = "16777216"
    }
}

resource "aws_db_subnet_group" "onebank-db-subnet" {
    name = "onebank-db-subnet"
    description = "RDS subnet group"
    subnet_ids = [ data.aws_subnet.main-public-1.id, data.aws_subnet.main-public-2.id ]
}

resource "aws_db_instance" "onebank-database" {
    db_name = local.database_name
    identifier = local.database_instance_name
    allocated_storage = 10
    instance_class = "db.t3.micro"
    engine = "mariadb"
    engine_version = "10.11"
    username = var.DB_USERNAME
    password = var.DB_PASSWORD
    storage_type = "gp2"
    backup_retention_period = 7
    multi_az = false
    availability_zone = data.aws_subnet.main-public-1.availability_zone
    parameter_group_name = aws_db_parameter_group.onebank-db-parameters.name
    db_subnet_group_name = aws_db_subnet_group.onebank-db-subnet.name
    vpc_security_group_ids = [ aws_security_group.allow-mariadb-sg.id ]
    tags = local.database_tags
}