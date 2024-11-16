locals {
    applicationId = lower(var.APPLICATION_ID)
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    bucket_name = "${local.applicationId}-fn-bucket"
    function_name = "${local.applicationId}-searchtask-fn"
    function_entrypoint = "com.onebank.taskmaster.searchtask.function.SearchTaskFunction"
 }