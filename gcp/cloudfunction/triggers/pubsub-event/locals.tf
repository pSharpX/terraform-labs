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
    function_name = "${local.applicationId}-emailsender-fn"
    function_entrypoint = "com.onebank.taskmaster.sendnotification.function.SendEmailNotificationFunctionEntryPoint"
    topic_name = "${local.applicationId}-notifications-channel"
    email_notification_subscription = "ob_email_notification_subs"
    push_notification_subscription = "ob_push_notification_subs"
    sms_notification_subscription = "ob_sms_notification_subs"
    publisher_sa_name = "${local.application_name}-publisher-sa"
    subscriber_sa_name = "${local.application_name}-subscriber-sa"
 }