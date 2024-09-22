# https://cloud.google.com/storage/docs/access-control#signed_urls_query_string_authentication

data "http" "download_object_successful" {
    url = data.google_storage_object_signed_url.signed_url_for_download.signed_url
    request_headers = {
      "Content-Type" = "text/html"
    }
    
    lifecycle {
        postcondition {
            condition = contains([200], self.status_code)
            error_message = "Status code invalid"
        }
    }
}

data "http" "download_object_failed" {
    url = data.google_storage_object_signed_url.signed_url_for_upload.signed_url
    
    lifecycle {
        postcondition {
            condition = contains([403], self.status_code)
            error_message = "Status code invalid"
        }
    }
}
