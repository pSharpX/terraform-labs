# Scale up alarm
resource "aws_autoscaling_policy" "onebank-cpu-policy-scaleup" {
    name = "onebank-cpu-policy-scaleup"
    autoscaling_group_name = aws_autoscaling_group.onebank-autoscaling.name
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = 1
    cooldown = 300
    policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "onebank-cpu-alarm-scaleup" {
    alarm_name = "onebank-cpu-alarm-scaleup"
    alarm_description = "This metric monitors ec2 cpu utilization"
    alarm_actions = [ aws_autoscaling_policy.onebank-cpu-policy-scaleup.arn ]
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = 2
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 120
    statistic = "Average"
    threshold = 80

    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.onebank-autoscaling.name
    }

    actions_enabled = true
    tags = local.common_tags
}

# Scale down alarm
resource "aws_autoscaling_policy" "onebank-cpu-policy-scaledown" {
    name = "onebank-cpu-policy-scaledown"
    autoscaling_group_name = aws_autoscaling_group.onebank-autoscaling.name
    adjustment_type = "ChangeInCapacity"
    scaling_adjustment = -1
    cooldown = 300
    policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "onebank-cpu-alarm-scaledown" {
    alarm_name = "onebank-cpu-alarm-scaledown"
    alarm_description = "This metric monitors ec2 cpu utilization"
    alarm_actions = [ aws_autoscaling_policy.onebank-cpu-policy-scaledown.arn ]
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = 2
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 120
    statistic = "Average"
    threshold = 10

    dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.onebank-autoscaling.name
    }

    actions_enabled = true
    tags = local.common_tags
}

