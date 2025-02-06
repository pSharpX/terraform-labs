# https://registry.terraform.io/providers/auth0/auth0/latest/docs/resources/user

resource "auth0_user" "onebank_super_admin" {
    connection_name = data.auth0_connection.username_password_connection.name
    email = "layoho9368@owlny.com"
    email_verified = false
    blocked = false
    nickname = "layoho9368"
    verify_email = false
    family_name = "layoho"
    given_name = "layoho"
    password = var.USER_PWD
    name = "layoho"
    picture = "https://gravatar.com/avatar/572ae90f7abd6b3f5903662e91e5cd61?s=400&d=robohash&r=x"

    user_metadata = jsonencode({
        "work_address" = "Somewhere Street"
        "home_address" = "Somewhere Else Street"
        "home_phone" = "000-000000"
    })
}

resource "auth0_user_role" "default_role" {
    user_id = auth0_user.onebank_super_admin.id
    role_id = data.auth0_role.administrator_role.id
}