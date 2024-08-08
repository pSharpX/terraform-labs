# https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http
# https://cloud.google.com/kms/docs/encrypt-decrypt#kms-encrypt-symmetric-api
# https://cloud.google.com/kms/docs/encrypt-decrypt-rsa
# https://cloud.google.com/kms/docs/retrieve-public-key#kms-get-public-key-api
# https://cloud.google.com/kms/docs/reference/rest#rest-resource:-v1.projects.locations.keyrings.cryptokeys.cryptokeyversions

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

data "http" "get_public_key_test_case" {
    url = "https://cloudkms.googleapis.com/v1/projects/${data.google_project.onebank.project_id}/locations/${local.keyring_ref.location}/keyRings/${local.keyring_ref.name}/cryptoKeys/${local.asymmetric_crypto_key_ref.name}/cryptoKeyVersions/1/publicKey"
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

resource "local_file" "public_key" {
    content = jsondecode(data.http.get_public_key_test_case.response_body)["pem"]
    filename = "./configs/public-key"

    lifecycle {
        precondition {
            condition = contains([200], data.http.get_public_key_test_case.status_code)
            error_message = "Previous step has failed"
        }
    }
}

resource "local_file" "secrets_file" {
    content = "This file contains secrets and other sensitive data."
    filename = "./configs/secrets.txt"

    lifecycle {
        precondition {
            condition = contains([200], data.http.get_public_key_test_case.status_code)
            error_message = "Previous step has failed"
        }
    }

    provisioner "local-exec" {
        command = "openssl pkeyutl -in ./configs/secrets.txt -encrypt -pubin -inkey ./configs/public-key -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256 -pkeyopt rsa_mgf1_md:sha256 > ./configs/encrypted_secrets.txt"
    }
}

data "http" "decryption_asymmetric_key_test_case" {
    url = "https://cloudkms.googleapis.com/v1/projects/${data.google_project.onebank.project_id}/locations/${local.keyring_ref.location}/keyRings/${local.keyring_ref.name}/cryptoKeys/${local.asymmetric_crypto_key_ref.name}/cryptoKeyVersions/1:asymmetricDecrypt"
    method = "POST"
    request_body = jsonencode({
        ciphertext = filebase64("./configs/encrypted_secrets.txt")
    })
    request_headers = {
        Authorization = "Bearer ${data.google_service_account_access_token.key_specific.access_token}"
    }

    lifecycle {
        precondition {
            condition = contains([200], data.http.get_public_key_test_case.status_code) && fileexists("./configs/encrypted_secrets.txt")
            error_message = "Encrypted file not found"
        }
        postcondition {
            condition = contains([200], self.status_code)
            error_message = "Status code invalid"
        }
    }

    depends_on = [ local_file.secrets_file ]
}
