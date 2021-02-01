terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

variable "gs_domain" {
  type = string
  default = "techhubphilly.com"
}

variable "gs_url" {
  type = string
  default = "getsquire"
}

provider "aws" {
  region  = "us-east-1"
  access_key = "AKIAJLDISYORBBRBSOUA"
  secret_key = "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"
}

resource "aws_vpc" "gs-vpc" {
  cidr_block = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  assign_generated_ipv6_cidr_block = true
  tags = {
    Name = "gs-vpc"
  }
}

resource "aws_subnet" "gs-sn-1" {
  vpc_id     = aws_vpc.gs-vpc.id
  cidr_block = "10.1.0.0/24"
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch = true
  ipv6_cidr_block = cidrsubnet(aws_vpc.gs-vpc.ipv6_cidr_block, 8, 1)
  tags = {
    Name = "gs-sn-1"
  }
}

resource "aws_subnet" "gs-sn-2" {
  vpc_id     = aws_vpc.gs-vpc.id
  cidr_block = "10.1.1.0/24"
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch = true
  ipv6_cidr_block = cidrsubnet(aws_vpc.gs-vpc.ipv6_cidr_block, 8, 8)
  tags = {
    Name = "gs-sn-2"
  }
}

resource "aws_internet_gateway" "getsquire_igw" {
  vpc_id = aws_vpc.gs-vpc.id
  tags = {
    Name = "GetSquire-IGW"
  }
}

resource "aws_route_table" "public_gs_rt" {
  vpc_id = aws_vpc.gs-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.getsquire_igw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.getsquire_igw.id
  }
  tags = {
    Name = "GetSquire Route Table"
  }
}

resource "aws_route_table_association" "gs_a" {
  subnet_id      = aws_subnet.gs-sn-1.id
  route_table_id = aws_route_table.public_gs_rt.id
}

resource "aws_route_table_association" "gs_b" {
  subnet_id      = aws_subnet.gs-sn-2.id
  route_table_id = aws_route_table.public_gs_rt.id
}


resource "aws_security_group" "sshhttphttps" {
  name        = "allow_ssh_sg"
  description = "Allow SSH inbound connections"
  vpc_id = aws_vpc.gs-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.gs-vpc.cidr_block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.gs-vpc.cidr_block]
  }

# ingress {
#   from_port   = 22
#   to_port     = 22
#   protocol    = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
# }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "getsquire_sg"
  }
}

resource "aws_key_pair" "getsquire" {
  key_name   = "getsquire-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTMQbG7ueglQUUXCQ04VjbhJpAj51t3mAl0kb5BerlELWzCX2/63fgl8ly4R5R1mTOGofl3mINJJV7dMLfO3D+YsvdWOykO5enVkamEsLixv4AqwsaJXsdfECRXCp6pQdk4IFOJoJA6PC1NV3fUkhBaYUn0j07IypaguUFsBiJsJJ1wplKDjmeVQ8AkXs5nGEMG0C0h9hUj8nI+SQiT2LsubHuEHxu3jWZvPA3YSiiHKfSwa0sBc7RY4vICqwjEYxKlItnZ/67cOP75DXw8UOLwY65XNXmneD/EBgFpAhPlbYCKTkFdLmr+lUPrim0Yz9zNeN42LRPTNid5dBZbGGb getsquire"
}

resource "aws_instance" "getsquirei1" {
  ami           = "ami-03503cee055fc9c47"
  instance_type = "t2.micro"
  key_name      = "getsquire-key"
  user_data     = <<-EOF
		          #! /bin/bash
                  echo "<h1>Hello World</h1>" > /var/www/html/index.nginx-debian.html
                  EOF
  subnet_id     = aws_subnet.gs-sn-1.id
  vpc_security_group_ids = [ aws_security_group.sshhttphttps.id ]
  tags = {
    Name = "getSquire-EC2"
    Number = "1"
  }

}

resource "aws_instance" "getsquirei2" {
  ami           = "ami-03503cee055fc9c47"
  instance_type = "t2.micro"
  key_name      = "getsquire-key"
  user_data     = <<-EOF
		          #! /bin/bash
                  echo "<h1>Hello World</h1>" > /var/www/html/index.nginx-debian.html
                  EOF
  subnet_id     = aws_subnet.gs-sn-2.id
  vpc_security_group_ids = [ aws_security_group.sshhttphttps.id ]
  tags = {
    Name = "getSquire-EC2"
    Number = "2"
  }

}
# Add Load Balancer

resource "aws_security_group" "gs_lb_sg" {
  name        = "allow_internet"
  description = "Allow Internet inbound traffic"
  vpc_id      = aws_vpc.gs-vpc.id

  ingress {
    description = "80 from world"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "GetSquire_LB_SecruityGroup"
  }
}

resource "aws_lb" "gs_lb" {
  name               = "getsquire-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.gs_lb_sg.id]
  subnets            = [aws_subnet.gs-sn-1.id, aws_subnet.gs-sn-2.id]
  ip_address_type    = "dualstack"
  enable_deletion_protection = false

  tags = {
    Name = "GetSQuireLB"
  }
}

resource "aws_lb_target_group" "gs_tg" {
  name     = "gs-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.gs-vpc.id
}

resource "aws_acm_certificate" "gs_acm_cert" {
  domain_name       = join(".",[var.gs_url, var.gs_domain])
  validation_method = "DNS"

  tags = {
    Name = "GetSquire-Domain"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "gs_route" {
  name         = var.gs_domain
  private_zone = false
}

resource "aws_route53_record" "gs_r53_records" {
  for_each = {
    for dvo in aws_acm_certificate.gs_acm_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.gs_route.zone_id
}

resource "aws_acm_certificate_validation" "gs_validate_cert" {
  certificate_arn         = aws_acm_certificate.gs_acm_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.gs_r53_records : record.fqdn]
}

resource "aws_lb_listener" "gs_lb_listener" {
  load_balancer_arn = aws_lb.gs_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate_validation.gs_validate_cert.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gs_tg.arn
  }
}

resource "aws_lb_listener" "gs_lb_listener_80" {
  load_balancer_arn = aws_lb.gs_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group_attachment" "gs_tg_att_1" {
  target_group_arn = aws_lb_target_group.gs_tg.arn
  target_id        = aws_instance.getsquirei1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "gs_tg_att_2" {
  target_group_arn = aws_lb_target_group.gs_tg.arn
  target_id        = aws_instance.getsquirei2.id
  port             = 80
}

resource "aws_wafv2_web_acl" "gs_waf_acl" {
  name  = "GetSquireWAF"
  scope = "REGIONAL"

  default_action {
    block {}
  }

  rule {
     action {
      allow {}
    }
    name     = "allowUS"
    priority = 1

    statement {
      geo_match_statement {
         country_codes = ["US"]
       }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "waf_acl_visibility_metric"
      sampled_requests_enabled   = false
    }
  }  
  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "outer_waf_acl_visibility_metric"
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_web_acl_association" "gs_waf_association" {
  resource_arn = aws_lb.gs_lb.arn
  web_acl_arn  = aws_wafv2_web_acl.gs_waf_acl.arn
}

resource "aws_route53_record" "gs_ep_ipv4" {
  zone_id = data.aws_route53_zone.gs_route.zone_id 
  name    = join(".",[var.gs_url, var.gs_domain])
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.gs_lb.dns_name]
}
