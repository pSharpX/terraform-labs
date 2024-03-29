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
        name = "ELBSubnets"
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
        value = "t3.medium"
    }
    setting {
        namespace = "aws:elasticbeanstalk:environment"
        name = "EnvironmentType"
        value = "LoadBalanced"
    }
    setting {
        namespace = "aws:elasticbeanstalk:environment"
        name = "ServiceRole"
        value = aws_iam_role.service_role.name
    }
    setting {
        namespace = "aws:elasticbeanstalk:environment"
        name = "LoadBalancerType"
        value = "application"
    }
    setting {
        namespace = "aws:elasticbeanstalk:environment:process:default"
        name = "HealthCheckPath"
        value = "/products-management/actuator/health"
    }
    setting {
        namespace = "aws:elasticbeanstalk:environment:process:default"
        name = "MatcherHTTPCode"
        value = "200"
    }
    setting {
        namespace = "aws:elbv2:loadbalancer"
        name = "SecurityGroups"
        value = aws_security_group.loadbalancer_sg.id
    }
    setting {
        namespace = "aws:elbv2:loadbalancer"
        name = "ManagedSecurityGroup"
        value = aws_security_group.loadbalancer_sg.id
    }
    setting {
        namespace = "aws:autoscaling:asg"
        name = "Cooldown"
        value = "300"
    }
    setting {
        namespace = "aws:autoscaling:asg"
        name = "MinSize"
        value = "2"
    }
    setting {
        namespace = "aws:autoscaling:asg"
        name = "MaxSize"
        value = "4"
    }
    setting {
        namespace = "aws:elasticbeanstalk:command"
        name = "BatchSizeType"
        value = "Percentage"
    }
    setting {
        namespace = "aws:elasticbeanstalk:command"
        name = "BatchSize"
        value = "30"
    }
    setting {
        namespace = "aws:autoscaling:updatepolicy:rollingupdate"
        name = "RollingUpdateType"
        value = "Health"
    }
    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name = "StreamLogs"
        value = true
    }
    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name = "DeleteOnTerminate"
        value = true #  Logs must be kept even after environment is terminated for real use-cases
    }
    setting {
        namespace = "aws:elasticbeanstalk:application:environment"
        name = "SPRING_DATASOURCE_URL"
        value = "jdbc:postgresql://${aws_db_instance.onebank_database.address}/${local.database_name}"
    }
    setting {
        namespace = "aws:elasticbeanstalk:application:environment"
        name = "SPRING_DATASOURCE_USERNAME"
        value = var.DB_USERNAME
    }
    setting {
        namespace = "aws:elasticbeanstalk:application:environment"
        name = "SPRING_DATASOURCE_PASSWORD"
        value = var.DB_PASSWORD
    }
    dynamic "setting" {
        for_each = var.APPLICATION_VARIABLES
        content {
            namespace = "aws:elasticbeanstalk:application:environment"
            name = setting.key
            value = setting.value
        }
    }

    tags = local.common_tags
    depends_on = [ aws_db_instance.onebank_database ]
}

