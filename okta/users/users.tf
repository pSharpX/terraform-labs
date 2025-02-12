# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/user

resource "okta_user" "admin_user" {
    email = "layoho9368@owlny.com"
    login = "layoho9368@owlny.com"
    first_name = "super"
    last_name = "admin"
    nick_name = "layoho9368"
    profile_url = "https://github.com/psharpx"
    display_name = "Ing. Layoho"
    title = "Software Engineer"
    locale = "es_PE"
    city = "Lima"
    password = var.USER_PWD
    state = "ACTIVE"
}

resource "okta_user" "users" {
    count = length(var.USERS)
    email = var.USERS[count.index].email
    login = var.USERS[count.index].email
    first_name = var.USERS[count.index].first_name
    last_name = var.USERS[count.index].last_name
    nick_name = var.USERS[count.index].nick_name
    profile_url = var.USERS[count.index].profile_url
    display_name = var.USERS[count.index].display_name
    title = "Software Engineer"
    locale = "es_PE"
    city = "Lima"
    password = var.USER_PWD
    state = var.USERS[count.index].state
}