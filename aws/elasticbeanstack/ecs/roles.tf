resource "aws_iam_role" "instance_role" {
    name = "onebank-instance-role"
    description = "Allows EC2 instances to call AWS services on your behalf."
    tags = local.common_tags
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "instance_ebs_webtier_role_policy" {
    role = aws_iam_role.instance_role.name
    policy_arn = data.aws_iam_policy.AWSElasticBeanstalkWebTier.arn
}

resource "aws_iam_role_policy_attachment" "instance_ebs_workertier_role_policy" {
    role = aws_iam_role.instance_role.name
    policy_arn = data.aws_iam_policy.AWSElasticBeanstalkWorkerTier.arn
}

resource "aws_iam_role_policy_attachment" "instance_ebs_multicontainerdocker_role_policy" {
    role = aws_iam_role.instance_role.name
    policy_arn = data.aws_iam_policy.AWSElasticBeanstalkMulticontainerDocker.arn
}

resource "aws_iam_role_policy_attachment" "instance_ecr_imagebuilder_role_policy" {
    role = aws_iam_role.instance_role.name
    policy_arn = data.aws_iam_policy.EC2InstanceProfileForImageBuilderECRContainerBuilds.arn
}

resource "aws_iam_instance_profile" "instance_profile_role" {
    name = "onebank-instance-profile"
    tags = local.common_tags
    role = aws_iam_role.instance_role.name
}

resource "aws_iam_role" "service_role" {
    name = "onebank-service-role"
    description = "Elastic Beanstalk uses a service role when it calls Amazon EC2, Elastic Load Balancing, and Amazon EC2 Auto Scaling APIs to gather information."
    tags = local.common_tags
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "elasticbeanstalk.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "service_ebs_health_role_policy" {
    role = aws_iam_role.service_role.name
    policy_arn = data.aws_iam_policy.AWSElasticBeanstalkEnhancedHealth.arn
}

resource "aws_iam_role_policy_attachment" "service_ebs_customer_role_policy" {
    role = aws_iam_role.service_role.name
    policy_arn = data.aws_iam_policy.AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy.arn
}
