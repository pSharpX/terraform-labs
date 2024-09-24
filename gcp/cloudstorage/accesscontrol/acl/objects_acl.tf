# https://cloud.google.com/storage/docs/access-control
# https://cloud.google.com/storage/docs/access-control/lists

# resource "google_storage_object_access_control" "photo_reader_allUsers" {
#     bucket = google_storage_bucket.assets.name
#     object = google_storage_bucket_object.assets_photo.output_name
#     role = "READER"
#     entity = "allUsers"
# }

resource "google_storage_object_acl" "photo_reader_allUsers" {
    bucket = google_storage_bucket.assets.name
    object = google_storage_bucket_object.assets_photo.output_name

    role_entity = [ 
        "READER:allUsers"
     ]
}