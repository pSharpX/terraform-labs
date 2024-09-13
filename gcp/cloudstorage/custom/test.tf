data "http" "read_file_successful" {
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
