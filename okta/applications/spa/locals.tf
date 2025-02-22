locals {
    applicationId = lower(var.APPLICATION_ID)
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    authorization_server = "${local.applicationId}-auth-server"
    rabbitmq_management_app = "${local.applicationId}-rabbitmq-management-spa"
    rabbitmq_consumer_m2m_app = "${local.applicationId}-rabbitmq-consumer-m2m"
    rabbitmq_producer_m2m_app = "${local.applicationId}-rabbitmq-producer-m2m"
    rabbitmq_roles = {
        administrator = "administrator"
        consumer = "consumer"
        producer = "producer"
    }
    rabbitmq_role_claim_expression = "isMemberOfGroupName(\"${okta_group.rabbitmq_administrator_group.name}\") ? \"${local.rabbitmq_roles.administrator}\" : isMemberOfGroupName(\"${okta_group.rabbitmq_producer_group.name}\") ? \"${local.rabbitmq_roles.producer}\" : isMemberOfGroupName(\"${okta_group.rabbitmq_consumer_group.name}\") ? \"${local.rabbitmq_roles.consumer}\" : \"\""
    taskmaster_app = "${local.applicationId}-taskmaster-web"
 }