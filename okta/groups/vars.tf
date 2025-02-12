
variable "ORG_NAME" {
    type = string
    description = "Org name of your Okta account"
}

variable "BASE_URL" {
    type = string
    description = "Domain of your Okta account"
}

variable "API_TOKEN" {
    type = string
    description = "API Token used to consume Okta Management API"
}

variable "APPLICATION_ID" {
    default = "onebank"
    type = string
    description = "Application Identifier"
}

variable "ENVIRONMENT" {
    default = "dev"
    type = string
    description = "Environment where resources are provisioned"

    validation {
      condition = contains(["dev", "uat", "staging", "prod"], var.ENVIRONMENT)
      error_message = "Allowed values for ENVIRONMENT are [dev, uat, staging, prod]"
    }
}

variable "TECHNICAL_OWNER" {
    default = "team_goat"
    type = string
    description = "Team responsable for application support"
}

variable "PROVISIONER" {
    default = "terraform"
    type = string
    description = "Tool used to provision resources"  
}

variable "DATA_CLASSIFICATION" {
    default = "restricted"
    type = string
    description = "A classification for the type of data managed by resources"
}

variable "DEVOPS" {
    type = map(object({
      first_name = string
      last_name = string
      nick_name = string
      display_name = string
      profile_url = string
      state = string
    }))
    description = "Map of users to be provisioned on Okta"
    default = {
        "jepali4941@intady.com" = {
            first_name = "jepali"
            last_name = "intady"
            nick_name = "jepali4941"
            profile_url = "https://github.com/psharpx"
            display_name = "Jepali"
            state = "ACTIVE"
        },
        "fidid60851@minduls.com" = {
            first_name = "fidid"
            last_name = "minduls"
            nick_name = "fidid60851"
            profile_url = "https://github.com/psharpx"
            display_name = "Fidid"
            state = "ACTIVE"
        },
        "falava8779@minduls.com" = {
            first_name = "falava"
            last_name = "minduls"
            nick_name = "falava8779"
            profile_url = "https://github.com/psharpx"
            display_name = "Falava"
            state = "SUSPENDED"
        }
    }
}

variable "DEVELOPERS" {
    type = map(object({
      first_name = string
      last_name = string
      nick_name = string
      display_name = string
      profile_url = string
      state = string
    }))
    description = "Map of users to be provisioned on Okta"
    default = {
        "tojapoj886@intady.com" = {
            first_name = "tojapoj"
            last_name = "intady"
            nick_name = "tojapoj886"
            profile_url = "https://github.com/psharpx"
            display_name = "Tojapoj"
            state = "ACTIVE"
        },
        "labebin272@intady.com" = {
            first_name = "labebin"
            last_name = "intady"
            nick_name = "labebin272"
            profile_url = "https://github.com/psharpx"
            display_name = "Labebin"
            state = "ACTIVE"
        },
        "cefipig918@nike4s.com" = {
            first_name = "cefipig"
            last_name = "nike4s"
            nick_name = "cefipig918"
            profile_url = "https://github.com/psharpx"
            display_name = "Cefipig"
            state = "SUSPENDED"
        }
    }
}

variable "USER_PWD" {
    type = string
    description = "Password for used being provisioned"
}

variable "ADMIN_GROUP" {
    type = string
    description = "Your default okta admin group"
}