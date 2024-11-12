locals {
    applicationId = lower(var.APPLICATION_ID)
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    connector_name = "${local.applicationId}-vpc-connector"
    connector_subnet = "vpc-connector-subnet-1"
    instance_name = "${local.applicationId}-db-instance"
    function_name = "${local.applicationId}-createtask-fn"
    function_entrypoint = "org.springframework.cloud.function.adapter.gcp.GcfJarLauncher"
    bucket_name = "${local.applicationId}-fn-bucket"
    bucket_object_name = "${local.function_name}-src.zip"
 }