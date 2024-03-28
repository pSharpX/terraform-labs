resource "aws_elastic_beanstalk_application" "onebank_application" {
    name = local.application_name
    description = "Platform where onebank application runs"
    tags = local.application_tags
}

resource "aws_elastic_beanstalk_application_version" "application_default_version" {
    name = "onebank-application-default-version"
    application = aws_elastic_beanstalk_application.onebank_application.name
    description = "Default application version created by terraform"
    bucket = aws_s3_bucket.onebank_application_storage.id
    key = aws_s3_object.application_assets.id
    tags = local.common_tags
}

resource "aws_elastic_beanstalk_environment" "onebank_development" {
    name = "${local.application_name}-development"
    application = aws_elastic_beanstalk_application.onebank_application.name
    version_label = aws_elastic_beanstalk_application_version.application_default_version.name
    description = "Environment for Development"
    tier = "WebServer"
    cname_prefix = local.applicationId
    solution_stack_name = data.aws_elastic_beanstalk_solution_stack.docker.name

    setting {
        namespace = "aws:ec2:vpc"
        name = "VPCId"
        value = data.aws_vpc.onebank_vpc.id
    }
    setting {
        namespace = "aws:ec2:vpc"
        name = "Subnets"
        value = join(",", var.PUBLIC_SUBNETS)
    }
    setting {
        namespace = "aws:ec2:vpc"
        name = "ELBScheme"
        value = "public"
    }
    setting {
        namespace = "aws:ec2:vpc"
        name = "AssociatePublicIpAddress"
        value = true
    }
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "EC2KeyName"
        value = aws_key_pair.onebank_key.key_name
    }
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "IamInstanceProfile"
        value = aws_iam_instance_profile.instance_profile_role.name
    }
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "SecurityGroups"
        value = aws_security_group.application_sg.id
    }
    setting {
        namespace = "aws:ec2:instances"
        name = "InstanceTypes"
        value = "t3.large"
    }
    setting {
        namespace = "aws:elasticbeanstalk:environment"
        name = "EnvironmentType"
        value = "SingleInstance" ## Default LoadBalanced
    }
    setting {
        namespace = "aws:elasticbeanstalk:environment"
        name = "ServiceRole"
        value = aws_iam_role.service_role.name
    }

    tags = local.common_tags
}

