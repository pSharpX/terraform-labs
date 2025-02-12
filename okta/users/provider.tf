terraform {
    required_providers {
        okta = {
            source = "okta/okta"
            version = "~> 4.14.0"
        }
    }
}

provider "okta" {
    org_name = var.ORG_NAME
    base_url = var.BASE_URL
    api_token = var.API_TOKEN
    //client_id = var.OKTA_CLIENT_ID
    //private_key_id = "[PRIVATE KEY ID - KID]"
    //private_key = "[PRIVATE KEY]"
    //scopes = "[COMMA,SEPARATED,SCOPE,VALUES]"
}