# The use of launch configurations is discouraged in favour of launch templates. Read more in the
# https://docs.aws.amazon.com/autoscaling/ec2/userguide/launch-configurations.html

resource "aws_launch_configuration" "onebank-launchconfig" {
    name_prefix = "onebank-launchconfig"
    image_id = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.onebank-keypair.key_name
    security_groups = [ aws_security_group.onebank-instance-sg.id ]
    user_data = filebase64(var.PATH_TO_USER_DATA)

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "onebank-autoscaling" {
    name = "onebank-autoscaling"
    launch_configuration = aws_launch_configuration.onebank-launchconfig.name
    vpc_zone_identifier = [ data.aws_subnet.main-public-1.id, data.aws_subnet.main-public-2.id ]
    desired_capacity = 2
    min_size = 2
    max_size = 4
    health_check_grace_period = 300
    health_check_type = "ELB"
    load_balancers = [ aws_elb.onebank-loadbalancer.name ]
    force_delete = true

    dynamic "tag" {
        for_each = local.common_tags
        content {
            key = tag.key
            value = tag.value
            propagate_at_launch = true
        }
    }

    lifecycle {
        create_before_destroy = true
    }
}