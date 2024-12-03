# https://cloud.google.com/pubsub/docs/access-control

resource "google_service_account" "default" {
    project = data.google_project.onebank.project_id
    account_id = "${local.application_name}-pubsub-sa"
    display_name = "Service Account for OneBank TaskMaster application"
    description = "Service Account for PubSub integration"
}

# Roles

# roles/pubsub.admin (can consume/publish) + setup IAM Policies
# roles/pubsub.editor (can consume/publish)
#
# Lowest-level resources where you can grant this role:
# 1. Schema
# 2. Snapshot
# 3. Subscription
# 4. Topic

# roles/pubsub.publisher
#
# Lowest-level resources where you can grant this role:
# 4. Topic

# roles/pubsub.subscriber
#
# Lowest-level resources where you can grant this role:
# 2. Snapshot
# 3. Subscription
# 4. Topic

# roles/pubsub.viewer (cannot consume/publish)
#
# Lowest-level resources where you can grant this role:
# 1. Schema
# 2. Snapshot
# 3. Subscription
# 4. Topic

resource "google_pubsub_topic_iam_member" "admin_member" {
  project = google_pubsub_topic.onebank_topic.project
  topic = google_pubsub_topic.onebank_topic.name
  role = "roles/pubsub.admin"
  member = "serviceAccount:${google_service_account.default.email}"
}

resource "google_service_account_key" "default_sa_key" {
    service_account_id = google_service_account.default.name
}

resource "local_sensitive_file" "default_account_credentials" {
    content = base64decode(google_service_account_key.default_sa_key.private_key)
    filename = "./configs/${local.application_name}-pubsub-sa.json"
}

data "google_service_account_access_token" "default_sa_access_token" {
    target_service_account = google_service_account.default.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]
}
