output "ecs_cluster_arn" {
  value = aws_ecs_cluster.application_cluster.arn
}

output "alb_dns_name" {
  description = "Public endpoint of the Application Load Balancer"
  value       = aws_lb.app_lb.dns_name
}

output "endpoint" {
  value = "http://${aws_lb.app_lb.dns_name}"
}