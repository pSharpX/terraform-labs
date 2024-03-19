locals {
    database_instance_name = "${var.APPLICATION_ID}db"
    database_name = "${var.APPLICATION_ID}db"
    instance_name = "${var.APPLICATION_ID}-backend"
    sg_name = "database-sg"
    instance_sg_name = "backend-sg"
    key_name = "${var.APPLICATION_ID}-key"
    common_tags = {
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
    engines_port = {
        "mariadb" = 3306
        "mysql" = 3306
        "postgres" = 5432
        "sqlserver-se" = 1433
    }
    database_tags = merge({Name = local.database_name}, local.common_tags)
    secgroup_tags = merge({Name = local.sg_name}, local.common_tags)
    instance_tags = merge({Name = local.instance_name}, local.common_tags)
    instance_sg_tags = merge({Name = local.instance_sg_name}, local.common_tags)
    key_tags = merge({Name = local.key_name}, local.common_tags)
}