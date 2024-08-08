output "project_number" {
    value = data.google_project.onebank.number
}

output "keyring_id" {
    value = try(local.keyring_ref.id)
}

output "crypto_key" {
    value = try(local.crypto_key_ref.id)
}

output "asymmetric_crypto_key" {
    value = try(local.asymmetric_crypto_key_ref.id)
}

output "primary_version" {
    value = one(try(local.asymmetric_crypto_key_ref.primary[*].name))
}

output "primary_version_state" {
    value = one(try(local.asymmetric_crypto_key_ref.primary[*].state))
}

output "encryption_test_case" {
  value = jsondecode(data.http.encryption_test_case.response_body)["ciphertext"]
}

output "decryption_test_case" {
  value = base64decode(jsondecode(data.http.decryption_test_case.response_body)["plaintext"])
}