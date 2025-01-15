locals {
    applicationId = lower(var.APPLICATION_ID)
    common_tags = {
        "application-id" = var.APPLICATION_ID
        "technical-owner" = var.TECHNICAL_OWNER
        "environment" = var.ENVIRONMENT
        "data-classification" = var.DATA_CLASSIFICATION
        "provisioner" = var.PROVISIONER
    }
    application_name = "taskmaster"
    bucket_name = "${local.applicationId}-fn-bucket"
    template_bucket_name = "${local.applicationId}-templates-bucket"
    function_name = "${local.applicationId}-templatemanager-fn"
    function_description = "Task Manager's Template manager"
    function_entrypoint = "com.onebank.taskmaster.templatemanager.function.ManageTemplateFunctionEntryPoint"
    topic_name = "${local.applicationId}-transport-topic"
    publisher_sa_name = "${local.application_name}-publisher-sa"
    subscriber_sa_name = "${local.application_name}-subscriber-sa"
    template_trigger = "${local.application_name}-templates-trigger"
 }