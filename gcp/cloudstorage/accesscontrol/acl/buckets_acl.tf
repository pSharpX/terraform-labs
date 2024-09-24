# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_access_control
# https://cloud.google.com/storage/docs/access-control
# https://cloud.google.com/storage/docs/access-control/lists

# resource "google_storage_bucket_access_control" "web_reader_allUsers" {
#     bucket = google_storage_bucket.web.name
#     role = "READER"
#     entity = "allUsers"
# }

resource "google_storage_bucket_acl" "web_reader_allUsers" {
    bucket = google_storage_bucket.web.name
    role_entity = [ 
        "READER:allUsers"
     ]
}