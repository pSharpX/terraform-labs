locals {
    instance_name = "${lower(var.APPLICATION_ID)}-instance"
    amis = {
        ubuntu = data.aws_ami.ubuntu.id
        amazonlinux = data.aws_ami.amazonlinux.id
        al2023 = data.aws_ami.al2023.id
        windows = data.aws_ami.ubuntu.id
    }
    scripts = {
        ubuntu = "./config/ubuntu_provisioner.sh"
        amazonlinux = "./config/amzn2_provisioner.sh"
        al2023 = "./config/al2023_provisioner.sh"
        windows = "./config/ubuntu_provisioner.sh"
    }
    users = {
        ubuntu = "ubuntu"
        amazonlinux = "ec2-user"
        al2023 = "ec2-user"
        windows = "ubuntu"
    }
    ami_id = lookup(local.amis, var.AMI_TYPE, "ubuntu")
    script = lookup(local.scripts, var.AMI_TYPE, "ubuntu")
    user = lookup(local.users, var.AMI_TYPE, "ubuntu")
    common_tags = {
        ApplicationId = var.APPLICATION_ID
        TechnicalOwner = var.TECHNICAL_OWNER
        Environment = var.ENVIRONMENT
        DataClassification = var.DATA_CLASSIFICATION
        Provisioner = var.PROVISIONER
    }
    instance_tags = merge({Name = local.instance_name}, local.common_tags)
}