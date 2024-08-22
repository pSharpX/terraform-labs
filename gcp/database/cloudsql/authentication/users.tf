# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user

# type: 
# It determines the method to authenticate the user during login. The default is the database's built-in user type.
# Flags include "BUILT_IN", "CLOUD_IAM_USER", and "CLOUD_IAM_SERVICE_ACCOUNT" for both Postgres and MySQL. MySQL also includes "CLOUD_IAM_GROUP", "CLOUD_IAM_GROUP_USER" and "CLOUD_IAM_GROUP_SERVICE_ACCOUNT".

# deletion_policy - (Optional) 
# The deletion policy for the user. 
# Setting ABANDON allows the resource to be abandoned rather than deleted. This is useful for Postgres, where users cannot be deleted from the API if they have been granted SQL roles.

resource "google_sql_user" "user_1" {
    name = var.DB_USER
    instance = google_sql_database_instance.instance_1.name
    host = "%"
    password = var.DB_PASSWORD
}

resource "google_sql_user" "iam_user_1" {
    #  # Note: for Postgres only, GCP requires omitting the ".gserviceaccount.com" suffix
    # from the service account email due to length limits on database usernames.
    name = google_service_account.sql_sa.email
    instance = google_sql_database_instance.instance_1.name
    #  For IAM users, password or hostname should not be specified., invalid
    # host = "%"
    type = "CLOUD_IAM_SERVICE_ACCOUNT"
    # deletion_policy = "ABANDON"
}

resource "google_sql_user" "user_2" {
    name = var.DB_USER
    instance = google_sql_database_instance.instance_2.name
    password = var.DB_PASSWORD
}

resource "google_sql_user" "iam_user_2" {
    #  # Note: for Postgres only, GCP requires omitting the ".gserviceaccount.com" suffix
    # from the service account email due to length limits on database usernames.
    name = trimsuffix(google_service_account.sql_sa.email, ".gserviceaccount.com")
    instance = google_sql_database_instance.instance_2.name
    #  For IAM users, password or hostname should not be specified., invalid
    # host = "%"
    type = "CLOUD_IAM_SERVICE_ACCOUNT"
    # deletion_policy = "ABANDON"
}