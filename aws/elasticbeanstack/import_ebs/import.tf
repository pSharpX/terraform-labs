import {
    to = aws_elastic_beanstalk_application.onebank
    id = "onebank-application"
}

import {
    to = aws_elastic_beanstalk_environment.onebankenv
    id = "e-4tm9emfxqn"
}

import {
    to = aws_iam_role.service_role
    id = "aws-elasticbeanstalk-service-role"
}

import {
    to = aws_iam_role.instance_role
    id = "ec2-elasticbeanstalk-role"
}

