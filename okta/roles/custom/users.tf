# https://registry.terraform.io/providers/okta/okta/latest/docs/resources/user

resource "okta_user" "super_admin_user" {
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

resource "okta_user" "readonly_admin_user" {
    email = "dawej46180@codverts.com"
    login = "dawej46180@codverts.com"
    first_name = "readonly"
    last_name = "admin"
    nick_name = "dawej46180"
    profile_url = "https://github.com/psharpx"
    display_name = "Ing. Layoho"
    title = "Software Engineer"
    locale = "es_PE"
    city = "Lima"
    password = var.USER_PWD
    state = "ACTIVE"
}

resource "okta_user" "users" {
    for_each = var.USERS
    email = each.key
    login = each.key
    first_name = each.value.first_name
    last_name = each.value.last_name
    nick_name = each.value.nick_name
    profile_url = each.value.profile_url
    display_name = each.value.display_name
    title = "Software Engineer"
    locale = "es_PE"
    city = "Lima"
    password = var.USER_PWD
    state = each.value.state
}

resource "okta_user" "administrators" {
    for_each = var.ADMINISTRATOR
    email = each.key
    login = each.key
    first_name = each.value.first_name
    last_name = each.value.last_name
    nick_name = each.value.nick_name
    profile_url = each.value.profile_url
    display_name = each.value.display_name
    title = "Software Engineer"
    locale = "es_PE"
    city = "Lima"
    password = var.USER_PWD
    state = each.value.state
}