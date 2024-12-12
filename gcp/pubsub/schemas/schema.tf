# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_schema

resource "google_pubsub_schema" "notification_message_schema" {
    name = local.notification_message_schema
    type = "AVRO"
    definition = <<EOF
    {
        "namespace":"onebank.taskmaster.notifier.avro",
        "type":"record",
        "name":"NotificationMessage",
        "doc":"Schema for Notification Message used in TaskMaster",
        "fields":[
            {
                "name":"id",
                "type":"int"
            },
            {
                "name":"channel",
                "type":"string"
            },
            {
                "name":"type",
                "type":"string"
            },
            {
                "name":"user",
                "type":"string"
            },
            {
                "name":"title",
                "type":"string"
            },
            {
                "name":"message",
                "type":"string"
            },
            {
                "name":"taskId",
                "type":"int"
            },
            {
                "name":"taskTitle",
                "type":"string"
            }
        ]
    }
    EOF
}