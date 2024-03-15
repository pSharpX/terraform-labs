resource "aws_lb" "onebank-loadbalancer" {
    name = local.elb_name
    internal = false
    load_balancer_type = "application"
    subnets = [ data.aws_subnet.main-public-1.id, data.aws_subnet.main-public-2.id ]
    security_groups = [ aws_security_group.onebank-elb-sg.id ]
    tags = local.elb_tags
}

resource "aws_lb_listener" "onebank-loadbalancer-listener" {
    load_balancer_arn = aws_lb.onebank-loadbalancer.arn
    port = 80
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.onebank-targetgroup.arn
    }
}

resource "aws_lb_target_group" "onebank-targetgroup" {
    name = "onebank-targetgroup"
    port = 80
    protocol = "HTTP"
    load_balancing_algorithm_type = "round_robin"
    vpc_id = data.aws_vpc.onebank-vpc.id

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        interval = 30
        port = 80
        protocol = "HTTP"
        timeout = 3
    }
}

resource "aws_autoscaling_attachment" "onebank-lb-autoscaling" {
    autoscaling_group_name = aws_autoscaling_group.onebank-autoscaling.id
    lb_target_group_arn = aws_lb_target_group.onebank-targetgroup.arn
}