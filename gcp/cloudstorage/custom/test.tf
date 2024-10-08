# https://cloud.google.com/storage/docs/authentication
# https://cloud.google.com/storage/docs/request-endpoints

data "http" "download_file_successful" {
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

data "http" "download_file_with_selfLink_successful" {
    url = "${google_storage_bucket_object.site.self_link}"
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

data "http" "download_file_with_mediaLink_successful" {
    url = "${google_storage_bucket_object.site.media_link}"
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