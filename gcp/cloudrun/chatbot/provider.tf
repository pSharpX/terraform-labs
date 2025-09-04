terraform {
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "7.1.1"
      }
    }
}

provider "google" {
    credentials = file(var.CREDENTIALS_FILE)
    project = var.PROJECT_ID
    #region = var.REGION
}

provider "google-beta" {
  credentials = file(var.CREDENTIALS_FILE)
    project = var.PROJECT_ID
    #region = var.REGION
}