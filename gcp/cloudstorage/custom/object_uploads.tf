# https://cloud.google.com/storage/docs/authentication
# https://cloud.google.com/storage/docs/request-endpoints
# https://cloud.google.com/storage/docs/uploading-objects#rest-upload-objects

data "http" "viewer_upload_object_failed" {
    url = "https://storage.googleapis.com/upload/storage/v1/b/${google_storage_bucket.default.name}/o?uploadType=media&name=photo-small.jpg"
    method = "POST"
    request_body = filebase64("./assets/photo-small.jpg")
    request_headers = {
        "Content-Type" = "image/jpeg"
        Authorization = "Bearer ${data.google_service_account_access_token.default_access_token.access_token}"
    }

    lifecycle {
        postcondition {
            condition = contains([403], self.status_code)
            error_message = "Status code invalid"
        }
    }
}

# data "http" "creator_upload_object_successful" {
#     url = "https://storage.googleapis.com/upload/storage/v1/b/${google_storage_bucket.default.name}/o?uploadType=media&name=photo-small.jpg"
#     method = "POST"
#     request_body = filebase64("./assets/photo-small.jpg")
#     request_headers = {
#         "Content-Type" = "application/octet-stream"
#         Authorization = "Bearer ${data.google_service_account_access_token.creator_access_token.access_token}"
#     }

#     lifecycle {
#         postcondition {
#             condition = contains([200], self.status_code)
#             error_message = "Status code invalid"
#         }
#     }
# }

data "http" "unauthorized_upload_object_failed" {
    url = "https://storage.googleapis.com/upload/storage/v1/b/${google_storage_bucket.default.name}/o?uploadType=media&name=photo-small.jpg"
    method = "POST"
    request_body = filebase64("./assets/photo-small.jpg")
    request_headers = {
        "Content-Type" = "image/jpeg"
        Authorization = "Bearer ${data.google_service_account_access_token.unauthorized_access_token.access_token}"
    }

    lifecycle {
        postcondition {
            condition = contains([403], self.status_code)
            error_message = "Status code invalid"
        }
    }
}