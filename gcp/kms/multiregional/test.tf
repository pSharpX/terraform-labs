# https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http
# https://cloud.google.com/kms/docs/encrypt-decrypt#kms-encrypt-symmetric-api

data "http" "encryption_test_case" {
    url = "https://cloudkms.googleapis.com/v1/projects/${data.google_project.onebank.project_id}/locations/${local.keyring_ref.location}/keyRings/${local.keyring_ref.name}/cryptoKeys/${local.crypto_key_ref.name}:encrypt"
    method = "POST"
    request_body = jsonencode({
        plaintext = base64encode("This is our secret!")
    })
    request_headers = {
        Authorization = "Bearer ${data.google_service_account_access_token.key_specific.access_token}"
    }

    lifecycle {
        postcondition {
            condition = contains([200], self.status_code)
            error_message = "Status code invalid"
        }
    }
}

data "http" "decryption_test_case" {
    url = "https://cloudkms.googleapis.com/v1/projects/${data.google_project.onebank.project_id}/locations/${local.keyring_ref.location}/keyRings/${local.keyring_ref.name}/cryptoKeys/${local.crypto_key_ref.name}:decrypt"
    method = "POST"
    request_body = jsonencode({
        ciphertext = jsondecode(data.http.encryption_test_case.response_body)["ciphertext"]
    })
    request_headers = {
        Authorization = "Bearer ${data.google_service_account_access_token.key_specific.access_token}"
    }

    lifecycle {
        precondition {
          condition = contains([200], data.http.encryption_test_case.status_code)
          error_message = "Previous step has failed"
        }
        postcondition {
            condition = contains([200], self.status_code)
            error_message = "Status code invalid"
        }
    }
}
