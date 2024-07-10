resource "google_service_account" "cluster_sa" {
    project = data.google_project.onebank.project_id
    account_id = "cluster-sa"
    display_name = "cluster-sa"
    description = "Service Account for K8S Cluster"
}

resource "google_service_account" "workload_identity_sa" {
    project = data.google_project.onebank.project_id
    account_id = "workload-identity"
    display_name = "workload-identity"
    description = "Service Account for Workloads Identity"
}

resource "google_project_iam_member" "logs_writer" {
    project = data.google_project.onebank.project_id
    role = "roles/logging.logWriter"
    member = "serviceAccount:${google_service_account.cluster_sa.email}"
}

resource "google_project_iam_member" "storage_viewer" {
    project = data.google_project.onebank.project_id
    role = "roles/storage.objectViewer"
    member = "serviceAccount:${google_service_account.cluster_sa.email}"
}

resource "google_project_iam_member" "storage_role" {
    project = data.google_project.onebank.project_id
    role = "roles/storage.admin"        ## <-- comment this out
    # role   = "roles/storage.objectAdmin"  ## <-- uncomment this
    member = "serviceAccount:${google_service_account.workload_identity_sa.email}"
}

resource "google_project_iam_member" "workload_identity_role" {
    project = data.google_project.onebank.project_id
    role   = "roles/iam.workloadIdentityUser"
    member = "serviceAccount:${data.google_project.onebank.project_id}.svc.id.goog[workload-identity-test/workload-identity-user]"
}

resource "google_service_account_key" "cluster_key" {
    service_account_id = google_service_account.cluster_sa.name
}

resource "local_file" "account_credentials" {
    content = base64decode(google_service_account_key.cluster_key.private_key)
    filename = "./configs/cluster-sa.json"
}