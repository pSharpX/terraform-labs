# https://cloud.google.com/sql/docs/mysql/iam-roles

resource "google_service_account" "sql_sa" {
    project = data.google_project.onebank.project_id
    account_id = "sql-sa"
    display_name = "Project-Level Service Account"
    description = "Service Account with Project-Level Cloud SQL permission"
}

# Roles
# roles/cloudsql.admin
# roles/cloudsql.editor
# roles/cloudsql.viewer
# roles/cloudsql.client
# roles/cloudsql.instanceUser

resource "google_project_iam_member" "client_role" {
    project = data.google_project.onebank.project_id
    role = "roles/cloudsql.client"
    member = "serviceAccount:${google_service_account.sql_sa.email}"
}

resource "google_project_iam_member" "instance_user_role" {
    project = data.google_project.onebank.project_id
    role = "roles/cloudsql.instanceUser"
    member = "serviceAccount:${google_service_account.sql_sa.email}"

    # condition {
    #     title = "Onebank Cloud SQL Instance"
    #     expression = "resource.name == 'projects/${data.google_project.onebank.project_id}/instances/myinstance' && resource.service == 'sqladmin.googleapis.com'"
    # }
}

resource "google_service_account_key" "sql_sa_key" {
    service_account_id = google_service_account.sql_sa.name

    depends_on = [ 
        google_project_iam_member.client_role,
        google_project_iam_member.instance_user_role
    ]
}

resource "local_file" "sql_sa_credentials_file" {
    content = base64decode(google_service_account_key.sql_sa_key.private_key)
    filename = "./configs/sql-sa.json"
}

data "google_service_account_access_token" "sql_sa_access_token" {
    target_service_account = google_service_account.sql_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]

    depends_on = [ 
        google_project_iam_member.client_role,
        google_project_iam_member.instance_user_role
    ]
}
