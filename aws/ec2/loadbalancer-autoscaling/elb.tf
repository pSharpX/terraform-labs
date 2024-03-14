resource "aws_elb" "onebank-loadbalancer" {
    name = local.elb_name
    subnets = [ data.aws_subnet.main-public-1.id, data.aws_subnet.main-public-2.id ]
    security_groups = [ aws_security_group.onebank-elb-sg.id ]

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:80/"
        interval = 30
    }

    cross_zone_load_balancing = true
    connection_draining = true
    connection_draining_timeout = 400
    tags = local.elb_tags
}