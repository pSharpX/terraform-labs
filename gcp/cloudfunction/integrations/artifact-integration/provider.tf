terraform {
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "6.10.0"
      }
    }
}

provider "google" {
    credentials = file(var.CREDENTIALS_FILE)
    project = var.PROJECT_ID
}

provider "google-beta" {
  credentials = file(var.CREDENTIALS_FILE)
    project = var.PROJECT_ID
}