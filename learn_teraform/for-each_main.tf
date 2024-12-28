variable "instances" {
  default = {
    frontend    =   {}
    cart    =   {}
    catalogue    =   {}
    shipping    =   {}
    payment    =   {}
    dispatch    =   {}        
    redis    =   {}
    user    =   {}
    rabbitmq    =   {}
    mysql    =   {}
    mongodb    =   {}
  }
}

resource "aws_instance" "instances" {
    for_each = var.instances
    ami = "ami-09c813fb71547fc4f"
    instance_type = "t3.small"
    vpc_security_group_ids = ["sg-0cbf02d2d2b330ea5"]
    tags = {
        Name  =    each.key
    }
}

resource "aws_route53_record" "frontend" {
    for_each = var.instances
    zone_id = "Z00485513VTKYH807UIM0"
    name    = "$(each.key)-dev.sarthak1207.shop"
    type    = "A"
    ttl     = "30"
    records = [aws_instance[each.key].private_ip]
}