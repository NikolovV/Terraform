# Create classic load balancer with listener and health_check
resource "aws_elb" "this" {
  name                      = "${terraform.workspace}-${var.aws_project_name}-elb"
  subnets                   = var.subnets
  security_groups           = var.elb_security_groups
  cross_zone_load_balancing = true

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  tags = var.resource_tags
}

# Define an instance configuration template that an Auto Scaling group uses to launch EC2 instances.
# Provide user data with initial configuration and configured standard EBS.
resource "aws_launch_configuration" "this" {
  name_prefix                 = "${terraform.workspace}-${var.aws_project_name}-tmpl_conf"
  image_id                    = var.web_image_id
  instance_type               = var.web_instance_type
  security_groups             = var.web_serv_security_groups
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd.x86_64
    systemctl start httpd.service
    systemctl enable httpd.service
    echo “Hello World from $(hostname -f)” > /var/www/html/index.html
  EOF

  root_block_device {
    volume_size = 8
    volume_type = "standard"
  }
}

# An Auto Scaling group collection of Amazon EC2 instances that are treated as a logical unit.
resource "aws_autoscaling_group" "this" {
  name                 = "${terraform.workspace}-${var.aws_project_name}-sc-gr"
  vpc_zone_identifier  = var.subnets
  desired_capacity     = var.web_desired_capacity
  max_size             = var.web_max_size
  min_size             = var.web_min_size
  launch_configuration = aws_launch_configuration.this.name
  load_balancers       = [aws_elb.this.name]
  health_check_type    = "ELB"

  # in case of aws_cloudwatch_metric_alarm configuration
  # enabled_metrics = [
  #   "GroupMinSize",
  #   "GroupMaxSize",
  #   "GroupDesiredCapacity",
  #   "GroupInServiceInstances",
  #   "GroupTotalInstances"
  # ]
  # metrics_granularity = "1Minute"

  lifecycle {
    create_before_destroy = true
  }

  tags = [var.resource_tags]
}

# Scaling metrics and threshold values for the CloudWatch alarms that invoke the scaling process.
# resource "aws_autoscaling_policy" "web_policy_up" {
#   name = "${terraform.warskpace}-web_policy_up"
#   scaling_adjustment = 1
#   adjustment_type = "ChangeInCapacity"
#   cooldown = 300
#   autoscaling_group_name = aws_autoscaling_group.this.name
# }

# Alarms based on anomaly detection models cannot have Auto Scaling actions.
# resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
#   alarm_name = "${terraform.warskpace}-web_cpu_alarm_down"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods = "2"
#   metric_name = "CPUUtilization"
#   namespace = "AWS/EC2"
#   period = "120"
#   statistic = "Average"
#   threshold = "10"

#   dimensions = {
#     AutoScalingGroupName = aws_autoscaling_group.this.name
#   }

#   alarm_description = "This metric monitor EC2 instance CPU utilization"
#   alarm_actions = [ aws_autoscaling_policy.web_policy_up.arn ]
# }

# Scaling metrics and threshold values for the CloudWatch alarms that invoke the scaling process. 
# resource "aws_autoscaling_policy" "web_policy_down" {
#   name = "${terraform.warskpace}-web_policy_down"
#   scaling_adjustment = -1
#   adjustment_type = "ChangeInCapacity"
#   cooldown = 300
#   autoscaling_group_name = aws_autoscaling_group.this.name
# }

# Alarms based on anomaly detection models cannot have Auto Scaling actions.
# resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
#   alarm_name = "${terraform.warskpace}-web_cpu_alarm_down"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods = "2"
#   metric_name = "CPUUtilization"
#   namespace = "AWS/EC2"
#   period = "120"
#   statistic = "Average"
#   threshold = "10"

#   dimensions = {
#     AutoScalingGroupName = aws_autoscaling_group.this.name
#   }

#   alarm_description = "This metric monitor EC2 instance CPU utilization"
#   alarm_actions = [ aws_autoscaling_policy.web_policy_down.arn ]
# }