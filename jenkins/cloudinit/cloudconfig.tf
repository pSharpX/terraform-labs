locals {
    playbooks_path = [
        "/opt/ping.yaml",
        "/opt/ansible-playbook.yaml",
        "/opt/playbooks/install_docker.yaml",
        "/opt/playbooks/install_jenkins.yaml",
        "/opt/playbooks/install_tools.yaml",
        "/opt/group_vars/jenkins-servers.yaml",
        "/opt/host_vars/master.yaml"
    ]
    playbooks_content = [
        file("./provisioner/ping.yaml"),
        file("./provisioner/playbook.yaml"),
        file("./provisioner/playbooks/install_docker.yaml"),
        file("./provisioner/playbooks/install_jenkins.yaml"),
        file("./provisioner/playbooks/install_tools.yaml"),
        file("./provisioner/group_vars/jenkins-servers.yaml"),
        file("./provisioner/host_vars/master.yaml")
    ]
}

data "template_file" "ansible_install" {
    template = file("./templates/ci_ansible_install.yaml.tmpl")

    vars = {
        ansible_rsa = file("./ssh/rsa")
        ansible_inventory = templatefile("./templates/inventory.tmpl", {
            jenkins_server = digitalocean_droplet.jenkins_server.ipv4_address
        })
        playbooks_path = join(",", local.playbooks_path)
        playbooks_content = join(",", local.playbooks_content)
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
