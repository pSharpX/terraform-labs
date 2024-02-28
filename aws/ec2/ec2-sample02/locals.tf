locals {
    backend_name = "${var.APPLICATION_ID}-backend"
    database_name = "${var.APPLICATION_ID}-database"
    frontend_name = "${var.APPLICATION_ID}-frontend"
    gateway_name = "${var.APPLICATION_ID}-gateway"
    backend_sg = "${local.backend_name}-sg"
    database_sg = "${local.database_name}-sg"
    frontend_sg = "${local.frontend_name}-sg"
    gateway_sg = "${local.gateway_name}-sg"
    key_name = "${var.APPLICATION_ID}-key"
    common_tags = {
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
    amis_data = {
        "ubuntu": data.aws_ami.ubuntu
    }
    backend_tags = merge({Name = local.backend_name}, local.common_tags)
    database_tags = merge({Name = local.database_name}, local.common_tags)
    frontend_tags = merge({Name = local.frontend_name}, local.common_tags)
    gateway_tags = merge({Name = local.gateway_name}, local.common_tags)
    backend_sg_tags = merge({Name = local.backend_sg}, local.common_tags)
    database_sg_tags = merge({Name = local.database_sg}, local.common_tags)
    frontend_sg_tags = merge({Name = local.frontend_sg}, local.common_tags)
    gateway_sg_tags = merge({Name = local.gateway_sg}, local.common_tags)
    key_tags = merge({Name = local.key_name}, local.common_tags)
}