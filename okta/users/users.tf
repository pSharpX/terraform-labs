# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/user

resource "okta_user" "default_user" {
    email = "layoho9368@owlny.com"
    login = "layoho9368@owlny.com"
    first_name = "layoho"
    last_name = "owlny"
    nick_name = "layoho9368"
    profile_url = "https://github.com/psharpx"
    display_name = "Ing. Layoho"
    title = "Tech Lead"
    city = "Lima"
    password = var.USER_PWD
    state = "ACTIVE"
}