# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam
# https://cloud.google.com/storage/docs/access-control/iam-roles

# Roles
# roles/storage.objectViewer
# roles/storage.objectCreator
# roles/storage.objectUser
# roles/storage.objectAdmin
# roles/storage.folderAdmin
# roles/storage.admin

resource "google_storage_bucket_iam_binding" "bucket_object_viewer_role" {
    bucket = google_storage_bucket.default.name
    role = "roles/storage.objectViewer"
    members = [ "allUsers" ]
}