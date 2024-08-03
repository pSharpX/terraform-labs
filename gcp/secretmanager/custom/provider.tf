terraform {
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "5.39.1"
      }

      http = {
        source = "hashicorp/http"
        version = "3.4.4"
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