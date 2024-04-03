data "template_file" "docker_script" {
    template = file(var.PROVISIONER_SCRIPT_PATH)

    vars = {
        USERNAME = var.USERNAME
    }
}