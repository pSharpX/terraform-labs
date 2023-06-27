locals {
    playbooks = [
        {
            path: "/opt/ping.yaml"
            content: "./provisioner/ping.yaml"
        },
        {
            path: "/opt/ansible-playbook.yaml"
            content: "./provisioner/playbook.yaml"
        },
        {
            path: "/opt/playbooks/install_docker.yaml"
            content: "./provisioner/playbooks/install_docker.yaml"
        },
        {
            path: "/opt/playbooks/install_jenkins.yaml"
            content: "./provisioner/playbooks/install_jenkins.yaml"
        },
        {
            path: "/opt/playbooks/install_tools.yaml"
            content: "./provisioner/playbooks/install_tools.yaml"
        },
    ]
}

data "template_file" "ansible_install" {
    template = file("./templates/ci_ansible_install.yaml.tmpl")

    vars = {
        ansible_rsa = file("./ssh/rsa")
        ansible_inventory = templatefile("./templates/inventory.tmpl", {
            jenkins_server = digitalocean_droplet.jenkins_server.ipv4_address
        })
        ansible_ping = file("./provisioner/ping.yaml")
        ansible_playbook = file("./provisioner/playbook.yaml")
    }

    depends_on = [ 
        digitalocean_droplet.jenkins_server 
    ]
}

data "template_cloudinit_config" "config" {
    gzip          = true
    base64_encode = true

    part {
        content_type = "text/cloud-config"
        filename     = "cloud-config.yaml"
        content      = "${data.template_file.ansible_install.rendered}"
    }

    part {
        content_type = "text/x-shellscript"
        filename     = "cloud-samples.sh"
        content  = <<-EOF
            #!/bin/bash
            echo "Hello World"
            EOF
    }
}

resource "local_file" "cloudinit_file" {
    content = data.template_file.ansible_install.rendered
    filename = "./data/cloudinit.yaml"
}
