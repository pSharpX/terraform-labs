# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function_iam
# https://cloud.google.com/functions/docs/reference/iam/roles

resource "google_service_account" "invoker_sa" {
    project = data.google_project.onebank.project_id
    account_id = "${local.applicationId}-fn-invoker-sa"
    display_name = "Function Invoker Service Account"
    description = "Service Account with Function Invoker Permission"
}

# Roles
# roles/cloudfunctions.admin
# roles/cloudfunctions.developer
# roles/cloudfunctions.invoker (only works for 1st gen functions)
# roles/run.invoker (For 2nd gen function use cloud run's roles)
# roles/cloudfunctions.viewer

# resource "google_cloudfunctions2_function_iam_member" "cfn_function_invoker_role" {
#     project = google_cloudfunctions2_function.main.project
#     cloud_function = google_cloudfunctions2_function.main.name
#     location = google_cloudfunctions2_function.main.location
#     role = "roles/cloudfunctions.invoker"
#     member = "serviceAccount:${google_service_account.invoker_sa.email}"
# }

# resource "google_cloud_run_service_iam_member" "run_invoker_role" {
#     project = google_cloudfunctions2_function.main.project
#     location = google_cloudfunctions2_function.main.location
#     service = google_cloudfunctions2_function.main.name
#     role = "roles/run.invoker"
#     member = "serviceAccount:${google_service_account.invoker_sa.email}"
# }


resource "google_cloudfunctions2_function_iam_member" "cfn_allUsers" {
    location = google_cloudfunctions2_function.main.location
    cloud_function = google_cloudfunctions2_function.main.name
    role = "roles/cloudfunctions.invoker"
    member = "allUsers"
}

resource "google_cloud_run_service_iam_member" "run_allUsers" {
    location = google_cloudfunctions2_function.main.location
    service = google_cloudfunctions2_function.main.name
    role = "roles/run.invoker"
    member = "allUsers"
}

resource "google_service_account_key" "invoker_key" {
    service_account_id = google_service_account.invoker_sa.name
}

resource "local_file" "invoker_account_credentials" {
    content = base64decode(google_service_account_key.invoker_key.private_key)
    filename = "./configs/onebank-fn-invoker-sa.json"
}

data "google_service_account_access_token" "invoker_access_token" {
    target_service_account = google_service_account.invoker_sa.email
    lifetime = "1800s"
    scopes = [ "cloud-platform", "userinfo-email" ]

    depends_on = [ 
        //google_cloudfunctions2_function_iam_member.cfn_function_invoker_role,
        //google_cloud_run_service_iam_member.run_invoker_role,
        google_cloudfunctions2_function_iam_member.cfn_allUsers,
        google_cloud_run_service_iam_member.run_allUsers
    ]
}