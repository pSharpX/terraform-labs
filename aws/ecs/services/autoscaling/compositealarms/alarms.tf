
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${local.service_name}-ecs-cpu-high"
  alarm_description   = "This metric monitors cpu utilization for ${local.service_name}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  tags                = local.common_tags

  dimensions = {
    ClusterName = data.aws_ecs_cluster.default.cluster_name
    ServiceName = aws_ecs_service.default_service.name
  }

  alarm_actions = [aws_appautoscaling_policy.cpu_scale_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${local.service_name}-ecs-cpu-low"
  alarm_description   = "This metric monitors cpu utilization for ${local.service_name}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 30
  tags                = local.common_tags

  dimensions = {
    ClusterName = data.aws_ecs_cluster.default.cluster_name
    ServiceName = aws_ecs_service.default_service.name
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  alarm_name          = "${local.service_name}-ecs-memory-high"
  alarm_description   = "This metric monitors memory utilization for ${local.service_name}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 75

  dimensions = {
    ClusterName = data.aws_ecs_cluster.default.cluster_name
    ServiceName = aws_ecs_service.default_service.name
  }

  alarm_actions = [aws_appautoscaling_policy.mem_scale_out.arn]
}

resource "aws_cloudwatch_metric_alarm" "memory_low" {
  alarm_name          = "${local.service_name}-ecs-memory-low"
  alarm_description   = "This metric monitors memory utilization for ${local.service_name}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 3
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 35

  dimensions = {
    ClusterName = data.aws_ecs_cluster.default.cluster_name
    ServiceName = aws_ecs_service.default_service.name
  }
}

resource "aws_cloudwatch_composite_alarm" "scale_in_composite" {
  alarm_name        = "ecs-scale-in-composite"
  alarm_description = "This composite metric monitors memory & cpu utilization for ${local.service_name} for scale in policy"
  alarm_rule        = "ALARM(${aws_cloudwatch_metric_alarm.cpu_low.alarm_name}) AND ALARM(${aws_cloudwatch_metric_alarm.memory_low.alarm_name})"

  # NOT SUPPORTED 
  #alarm_actions = [
  #  aws_appautoscaling_policy.scale_in_policy.arn
  #]

  # INSTEAD (SNS, LAMBDA, EVENT BRIDGE are supported)
  #alarm_actions = [
  #  aws_sns_topic.scale_in_policy.arn
  #]

  depends_on = [
    aws_cloudwatch_metric_alarm.cpu_low,
    aws_cloudwatch_metric_alarm.memory_low
  ]
}
