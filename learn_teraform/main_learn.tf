resource "aws_instance" "frontend" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0cbf02d2d2b330ea5"]
  tags = {
    Name  =    "frontend"
  }
}

resource "aws_route53_record" "frontend" {
  zone_id = "Z00485513VTKYH807UIM0"
  name    = "frontend-dev.sarthak1207.shop"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "catalogue" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0cbf02d2d2b330ea5"]
  tags = {
    Name  =    "catalogue"
  }
}

resource "aws_route53_record" "catalogue" {
  zone_id = "Z00485513VTKYH807UIM0"
  name    = "catalogue-dev.sarthak1207.shop"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.catalogue.private_ip]
}

resource "aws_instance" "cart" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0cbf02d2d2b330ea5"]
  tags = {
    Name  =    "cart"
  }
}

resource "aws_route53_record" "cart" {
  zone_id = "Z00485513VTKYH807UIM0"
  name    = "cart-dev.sarthak1207.shop"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.cart.private_ip]
}

resource "aws_instance" "mongodb" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0cbf02d2d2b330ea5"]
  tags = {
    Name  =    "mongodb"
  }
}

resource "aws_route53_record" "mongodb" {
  zone_id = "Z00485513VTKYH807UIM0"
  name    = "mongodb-dev.sarthak1207.shop"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.mongodb.private_ip]
}

resource "aws_instance" "dispatch" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0cbf02d2d2b330ea5"]
  tags = {
    Name  =    "dispatch"
  }
}

resource "aws_route53_record" "dispatch" {
  zone_id = "Z00485513VTKYH807UIM0"
  name    = "dispatch-dev.sarthak1207.shop"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.dispatch.private_ip]
}

resource "aws_instance" "mysql" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0cbf02d2d2b330ea5"]
  tags = {
    Name  =    "mysql"
  }
}

resource "aws_route53_record" "mysql" {
  zone_id = "Z00485513VTKYH807UIM0"
  name    = "mysql-dev.sarthak1207.shop"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.mysql.private_ip]
}

resource "aws_instance" "payment" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0cbf02d2d2b330ea5"]
  tags = {
    Name  =    "payment"
  }
}

resource "aws_route53_record" "payment" {
  zone_id = "Z00485513VTKYH807UIM0"
  name    = "payment-dev.sarthak1207.shop"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.payment.private_ip]
}

resource "aws_instance" "shipping" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0cbf02d2d2b330ea5"]
  tags = {
    Name  =    "shipping"
  }
}

resource "aws_route53_record" "shipping" {
  zone_id = "Z00485513VTKYH807UIM0"
  name    = "shipping-dev.sarthak1207.shop"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.shipping.private_ip]
}

resource "aws_instance" "rabbitmq" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0cbf02d2d2b330ea5"]
  tags = {
    Name  =    "rabbitmq"
  }
}

resource "aws_route53_record" "rabbitmq" {
  zone_id = "Z00485513VTKYH807UIM0"
  name    = "rabbitmq-dev.sarthak1207.shop"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.rabbitmq.private_ip]
}

resource "aws_instance" "user" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0cbf02d2d2b330ea5"]
  tags = {
    Name  =    "user"
  }
}

resource "aws_route53_record" "user" {
  zone_id = "Z00485513VTKYH807UIM0"
  name    = "user-dev.sarthak1207.shop"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.user.private_ip]
}

resource "aws_instance" "redis" {
  ami = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0cbf02d2d2b330ea5"]
  tags = {
    Name  =    "redis"
  }
}

resource "aws_route53_record" "redis" {
  zone_id = "Z00485513VTKYH807UIM0"
  name    = "redis-dev.sarthak1207.shop"
  type    = "A"
  ttl     = "30"
  records = [aws_instance.redis.private_ip]
}