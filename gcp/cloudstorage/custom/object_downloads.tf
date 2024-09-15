# https://cloud.google.com/storage/docs/authentication
# https://cloud.google.com/storage/docs/request-endpoints
# https://cloud.google.com/storage/docs/downloading-objects

data "http" "viewer_download_object_successful" {
    url = "https://storage.googleapis.com/storage/v1/b/${google_storage_bucket.default.name}/o/${google_storage_bucket_object.site.output_name}?alt=media"
    request_headers = {
        Authorization = "Bearer ${data.google_service_account_access_token.default_access_token.access_token}"
    }

    lifecycle {
        postcondition {
            condition = contains([200], self.status_code)
            error_message = "Status code invalid"
        }
    }
}

data "http" "creator_download_object_failed" {
    url = "https://storage.googleapis.com/storage/v1/b/${google_storage_bucket.default.name}/o/${google_storage_bucket_object.site.output_name}?alt=media"
    request_headers = {
        Authorization = "Bearer ${data.google_service_account_access_token.creator_access_token.access_token}"
    }

    lifecycle {
        postcondition {
            condition = contains([403], self.status_code)
            error_message = "Status code invalid"
        }
    }
}

data "http" "unauthorized_download_object_failed" {
    url = "https://storage.googleapis.com/storage/v1/b/${google_storage_bucket.default.name}/o/${google_storage_bucket_object.site.output_name}?alt=media"
    request_headers = {
        Authorization = "Bearer ${data.google_service_account_access_token.unauthorized_access_token.access_token}"
    }

    lifecycle {
        postcondition {
            condition = contains([403], self.status_code)
            error_message = "Status code invalid"
        }
    }
}
