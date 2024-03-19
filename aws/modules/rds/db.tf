module "db" {
    source = "terraform-aws-modules/rds/aws"

    identifier = local.rds_name

    engine = "mysql"
    engine_version = "5.7"
    instance_class = "db.t3.micro"
    allocated_storage = "10"
    storage_type = "gp2"

    db_name = local.database_name
    username = var.DB_USERNAME
    port = "3306"

    iam_database_authentication_enabled = true
    vpc_security_group_ids = [aws_security_group.database_sg.id]
    publicly_accessible = false

    tags = local.common_tags

    # DB subnet group
    create_db_subnet_group = true
    subnet_ids = var.DB_SUBNETS

    # DB parameter group
    family = "mysql5.7"

    # DB option group
    major_engine_version = "5.7"

    # Database Deletion Protection
    deletion_protection = true
}