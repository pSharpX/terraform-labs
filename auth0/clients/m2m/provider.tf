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
    client_id = var.AUTH0_CLIENT_ID
    client_secret = var.AUTH0_CLIENT_SECRET
    audience = var.AUTH0_AUDIENCE
    debug         = false
}