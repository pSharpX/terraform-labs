output "vpc-id" {
    value = aws_vpc.vpc-sample01.id
}

output "vpc-arn" {
    value = aws_vpc.vpc-sample01.arn
}

output "vpc-subnets" {
    value = {
        "main-public-1" = aws_subnet.main-public-1.id
        "main-public-2" = aws_subnet.main-public-2.id
        "main-public-3" = aws_subnet.main-public-3.id
        "main-private-1" = aws_subnet.main-private-1.id
        "main-private-2" = aws_subnet.main-private-2.id
        "main-private-3" = aws_subnet.main-private-3.id
    }
}