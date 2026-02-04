
# Amazon ECS Managed Instances Instance Families
#
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/managed-instances-instance-types.html


resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs-managed-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
}


resource "aws_ecs_capacity_provider" "gp_cap_provider" {
    name = "gp-onebank-cluster-cp"
    cluster = aws_ecs_cluster.onebank_cluster.name
    tags = local.common_tags

    managed_instances_provider {
        infrastructure_role_arn = aws_iam_role.ecs_managed_instances_infra_role.arn
        propagate_tags = "CAPACITY_PROVIDER"

        instance_launch_template {
            capacity_option_type = "ON_DEMAND"
            ec2_instance_profile_arn = aws_iam_instance_profile.ecs_instance_profile.arn

            instance_requirements {
                allowed_instance_types = [
                    "m5.*",
                    "m6.*",
                    "m7.*"
                ]
                #cpu_manufacturers = [ "amd", "intel", "amazon-web-services" ]
                #local_storage_types = ["hdd", "ssd"]

                memory_mib {
                    min = 1024
                    max = 16384
                }
                vcpu_count {
                    min = 1
                    max = 8
                }
            }

            network_configuration {
                subnets = [
                    data.aws_subnet.default_subnet.id
                ]
                security_groups = [
                    aws_security_group.ecs_managed_instances_sg.id
                ]
            }

            storage_configuration {
                storage_size_gib = 30
            }
        }
    } 
}

resource "aws_ecs_cluster_capacity_providers" "default_capacity_provider" {
    cluster_name = aws_ecs_cluster.onebank_cluster.name
    capacity_providers = [
        aws_ecs_capacity_provider.gp_cap_provider.name
    ]

    default_capacity_provider_strategy {
        weight = 100
        base = 1
        capacity_provider = aws_ecs_capacity_provider.gp_cap_provider.name
    }

    depends_on = [
        aws_ecs_capacity_provider.gp_cap_provider
    ]
}
