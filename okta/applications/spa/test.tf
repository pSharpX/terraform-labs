resource "time_sleep" "wait_10s" {
    create_duration = "10s"

    depends_on = [
        okta_auth_server.onebank,
        okta_auth_server_scope.rabbitmq_configure_scope,
        okta_auth_server_scope.rabbitmq_write_scope,
        okta_auth_server_scope.rabbitmq_read_scope,
        okta_auth_server_scope.taskmaster_configure_scope,
        okta_auth_server_scope.taskmaster_write_scope,
        okta_auth_server_scope.taskmaster_read_scope,
        okta_auth_server_policy_rule.taskmaster_default_rule,
        okta_app_oauth.rabbitmq_app,
        okta_app_oauth.taskmaster_app
    ]
}

data "http" "test_rabbitmq_access_token" {
    url = "${okta_auth_server.onebank.issuer}/v1/token"
    method = "POST"
    request_headers = {
        "Content-Type" = "application/x-www-form-urlencoded"
    }
    request_body = "grant_type=client_credentials&client_id=${okta_app_oauth.rabbitmq_app.client_id}&client_secret=${okta_app_oauth.rabbitmq_app.client_secret}&scope=${okta_auth_server_scope.rabbitmq_write_scope.name}"

    lifecycle {
        postcondition {
            condition = contains([400], self.status_code)
            error_message = "Status code invalid"
        }
    }

    depends_on = [
        time_sleep.wait_10s       
    ]
}

data "http" "test_taskmaster_access_token" {
    url = "${okta_auth_server.onebank.issuer}/v1/token"
    method = "POST"
    request_headers = {
        "Content-Type" = "application/x-www-form-urlencoded"
    }
    request_body = "grant_type=client_credentials&client_id=${okta_app_oauth.taskmaster_app.client_id}&client_secret=${okta_app_oauth.taskmaster_app.client_secret}&scope=${okta_auth_server_scope.taskmaster_write_scope.name}"

    lifecycle {
        postcondition {
            condition = contains([400], self.status_code)
            error_message = "Status code invalid"
        }
    }

    depends_on = [
        time_sleep.wait_10s       
    ]
}