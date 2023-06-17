terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.28.1"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.21.1"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    
    http = {
      source = "hashicorp/http"
      version = "3.3.0"
    }
  }
}

provider "digitalocean" {
  token = "${var.DIGITALOCEAN_TOKEN}"
}

provider "kubernetes" {
  config_path = "${local_file.kube_config.filename}"
}

provider "kubectl" {
  config_path = "${local_file.kube_config.filename}"
}