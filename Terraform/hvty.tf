variable "accesskey" {}
variable "secretkey" {}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

variable "hv_domain" {
  type = string
  default = "techhubphilly.com"
}

variable "hv_url" {
  type = string
  default = "hvty"
}

provider "aws" {
  region  = "us-east-1"
  access_key = var.accesskey
  secret_key = var.secretkey
}

resource "aws_vpc" "hv-vpc" {
  cidr_block = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  assign_generated_ipv6_cidr_block = true
  tags = {
    Name = "hv-vpc"
  }
}

resource "aws_subnet" "hv-sn-1" {
  vpc_id     = aws_vpc.hv-vpc.id
  cidr_block = "10.1.0.0/24"
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch = true
  ipv6_cidr_block = cidrsubnet(aws_vpc.hv-vpc.ipv6_cidr_block, 8, 1)
  tags = {
    Name = "hv-sn-1"
  }
}

resource "aws_subnet" "hv-sn-2" {
  vpc_id     = aws_vpc.hv-vpc.id
  cidr_block = "10.1.1.0/24"
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch = true
  ipv6_cidr_block = cidrsubnet(aws_vpc.hv-vpc.ipv6_cidr_block, 8, 8)
  tags = {
    Name = "hv-sn-2"
  }
}

resource "aws_internet_gateway" "hvty_igw" {
  vpc_id = aws_vpc.hv-vpc.id
  tags = {
    Name = "hvty-IGW"
  }
}

resource "aws_route_table" "public_hv_rt" {
  vpc_id = aws_vpc.hv-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hvty_igw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.hvty_igw.id
  }
  tags = {
    Name = "hvty Route Table"
  }
}

resource "aws_route_table_association" "hv_a" {
  subnet_id      = aws_subnet.hv-sn-1.id
  route_table_id = aws_route_table.public_hv_rt.id
}

resource "aws_security_group" "sshhttphttps" {
  name        = "allow_ssh_sg"
  description = "Allow SSH inbound connections"
  vpc_id = aws_vpc.hv-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.hv-vpc.cidr_block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.hv-vpc.cidr_block]
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
    Name = "hvty_sg"
  }
}

resource "aws_key_pair" "hvty" {
  key_name   = "hvty-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTMQbG7ueglQUUXCQ04VjbhJpAj51t3mAl0kb5BerlELWzCX2/63fgl8ly4R5R1mTOGofl3mINJJV7dMLfO3D+YsvdWOykO5enVkamEsLixv4AqwsaJXsdfECRXCp6pQdk4IFOJoJA6PC1NV3fUkhBaYUn0j07IypaguUFsBiJsJJ1wplKDjmeVQ8AkXs5nGEMG0C0h9hUj8nI+SQiT2LsubHuEHxu3jWZvPA3YSiiHKfSwa0sBc7RY4vICqwjEYxKlItnZ/67cOP75DXw8UOLwY65XNXmneD/EBgFpAhPlbYCKTkFdLmr+lUPrim0Yz9zNeN42LRPTNid5dBZbGGb hvty"
}


resource "aws_launch_configuration" "hv_web" {
  name_prefix = "web-"

  image_id = "ami-03503cee055fc9c47"
  instance_type = "t2.micro"
  key_name = "hvty-key"

  security_groups = [ aws_security_group.sshhttphttps.id]
  associate_public_ip_address = true
  user_data     = <<-EOF
		          #! /bin/bash
                  echo "<h1>Hello World</h1>" > /var/www/html/index.nginx-debian.html
                  EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "hv_asg" {
  name = "hvty-my-asg"

  min_size             = 1
  desired_capacity     = 2
  max_size             = 4
  
  health_check_type    = "ELB"

  launch_configuration = aws_launch_configuration.hv_web.name
  target_group_arns = [ aws_lb_target_group.hv_tg.arn]
  #load_balancers = [ aws_lb.hv_lb.id ]
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  vpc_zone_identifier  = [aws_subnet.hv-sn-1.id, aws_subnet.hv-sn-2.id]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "hv-Web"
    propagate_at_launch = true
  }

}

# Add Load Balancer
resource "aws_security_group" "hv_lb_sg" {
  name        = "allow_internet"
  description = "Allow Internet inbound traffic"
  vpc_id      = aws_vpc.hv-vpc.id

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
    Name = "hvty_LB_SecruityGroup"
  }
}

resource "aws_lb" "hv_lb" {
  name               = "hvty-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.hv_lb_sg.id]
  subnets            = [aws_subnet.hv-sn-1.id, aws_subnet.hv-sn-2.id]
  ip_address_type    = "dualstack"
  enable_deletion_protection = false

  tags = {
    Name = "hvtyLB"
  }
}

resource "aws_lb_target_group" "hv_tg" {
  name     = "hv-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.hv-vpc.id
}

#resource "aws_autoscaling_attachment" "asg_attachment_bar" {
#  autoscaling_group_name = aws_autoscaling_group.hv_asg.id
#  elb                    = aws_lb.hv_lb.id
#}

resource "aws_lb_listener" "hv_lb_listener" {
  load_balancer_arn = aws_lb.hv_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.hv_acm_cert.arn
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hv_tg.arn
  }
}

resource "aws_acm_certificate" "hv_acm_cert" {
  domain_name       = join(".",[var.hv_url, var.hv_domain])
  validation_method = "DNS"

  tags = {
    Name = "hvty-Domain"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "hv_route" {
  name         = var.hv_domain
  private_zone = false
}

resource "aws_lb_listener" "hv_lb_listener_80" {
  load_balancer_arn = aws_lb.hv_lb.arn
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

