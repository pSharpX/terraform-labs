
resource "aws_ecs_cluster" "onebank_cluster" {
    name = local.cluster_name
    tags = local.cluster_tags

    setting {
        name = "containerInsights"
        value = "enabled"
    }
}
