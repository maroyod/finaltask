provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["D:\\key\\cred"]
}

resource "aws_lb" "elb_example" {
  name               = "elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.public_1.id,aws_subnet.public_2.id]

  # enable_deletion_protection = true
    tags = {
    Environment = "elb-example"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.elb_example.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.test.arn

    }
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  target_type="instance"
  vpc_id   = aws_vpc.vpc_demo.id
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.elb_instance_example1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "test1" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.elb_instance_example2.id
  port             = 80
}


output "elb_example" {
  description = "The DNS name of the ELB"
  value       = aws_lb.elb_example.dns_name
}





resource "aws_lb" "elb_example1" {
  name               = "elb1"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.private_1.id,aws_subnet.private_2.id]

  # enable_deletion_protection = true
    tags = {
    Environment = "elb-example1"
  }
}

resource "aws_lb_listener" "front_end1" {
  load_balancer_arn = aws_lb.elb_example1.arn
  port              = "81"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.test1.arn

    }
}

resource "aws_lb_target_group" "test1" {
  name     = "tf-example-lb-tg1"
  port     = 80
  protocol = "HTTP"
  target_type="instance"
  vpc_id   = aws_vpc.vpc_demo.id
}

resource "aws_lb_target_group_attachment" "test3" {
  target_group_arn = aws_lb_target_group.test1.arn
  target_id        = aws_instance.elb_instance_example3.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "test4" {
  target_group_arn = aws_lb_target_group.test1.arn
  target_id        = aws_instance.elb_instance_example4.id
  port             = 80
}


output "elb_example1" {
  description = "The DNS name of the ELB"
  value       = aws_lb.elb_example1.dns_name
}

