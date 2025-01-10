# # For testing Cloud Event Function functionality

# data "http" "test_emailsender_fn" {
#     url = google_cloudfunctions2_function.main.url
#     method = "POST"
#     request_headers = {
#         Authorization = "Bearer ${data.google_service_account_id_token.invoker_oidc_token.id_token}"
#     }
#     request_body = jsonencode({
#         "data" = {
#             "data" = base64encode(jsonencode({
#                 "id" = 1
#                 "channel" = "EMAIL"
#                 "type" = "TASK_CREATED"
#                 "user" = var.RECIPIENT_EMAIL
#                 "title" = "Learn Terraform"
#                 "message" = "Learn Terraform from scratch"
#                 "recipientName" = var.RECIPIENT_NAME
#                 "recipientEmail" = var.RECIPIENT_EMAIL
#                 "templateName" = "task-created-template"
#                 "vars" = {
#                     "application_name" = "Task Master",
#                     "username" = "Christian Rivera",
#                     "current_year" = "2025",
#                     "task_title" = "Learn Terraform"
#                     "task_description" = "Learn Terraform from Scratch"
#                     "task_due_date" = "10/10/2025"
#                     "task_priority" = "Low"
#                 }
#             }))
#         },
#         "context" = {
#             "eventId" = "1",
#             "eventType" = "google.pubsub.topic.publish",
#             "resource" = {
#                 "name" = google_pubsub_topic.onebank_topic.name,
#                 "service" = "pubsub.googleapis.com",
#                 "type" = "type.googleapis.com/google.pubsub.v1.PubsubMessage"
#             },
#             "timestamp" = "2024-12-30T16:22:43.946Z"
#         }
#     })

#     lifecycle {
#         postcondition {
#             condition = contains([200], self.status_code)
#             error_message = "Status code invalid"
#         }
#     }

#     depends_on = [ 
#         time_sleep.wait_60s_for_invoker
#     ]
# }