# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring
# https://cloud.google.com/kms/docs/reference/rest/v1/projects.locations.keyRings.cryptoKeys

# KeyRings cannot be deleted from Google Cloud Platform. 
# Destroying a Terraform-managed KeyRing will remove it from state but will not delete the resource from the project.#

resource "google_kms_key_ring" "onebank_keyring" {
    count = local.create_keyring
    name = local.keyring_name
    # gcloud kms locations list
    location = var.LOCATION_ID

    # lifecycle {
    #     prevent_destroy = true
    # }
}
