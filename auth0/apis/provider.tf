terraform {
    required_providers {
        auth0 = {
            source = "auth0/auth0"
            version = "1.11.1"
        }
    }
}

provider "auth0" {
    domain        = var.DOMAIN
    api_token = var.API_TOKEN
    debug         = false
}