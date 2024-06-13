terraform {
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "5.23.0"
      }

      google-beta = {
        source = "hashicorp/google-beta"
        version = "5.24.0"
      }
    }
}

provider "google" {
    credentials = file(var.CREDENTIALS_FILE)
    project = var.PROJECT_ID
    region = var.REGION
    zone = var.ZONE
}

provider "google-beta" {
  credentials = file(var.CREDENTIALS_FILE)
    project = var.PROJECT_ID
    region = var.REGION

    user_project_override = true
}