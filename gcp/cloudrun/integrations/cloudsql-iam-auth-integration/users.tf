# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user

resource "google_sql_user" "admin" {
    #  # Note: for Postgres only, GCP requires omitting the ".gserviceaccount.com" suffix
    # from the service account email due to length limits on database usernames.
    name = local.username
    instance = google_sql_database_instance.onebank_instance.name
    #  For IAM users, password or hostname should not be specified., invalid
    # host = "%"
    type = "CLOUD_IAM_SERVICE_ACCOUNT"
    # deletion_policy = "ABANDON"
}