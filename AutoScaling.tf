#template
resource "aws_launch_template" "template-1" {
  name          = "terraformtemp"
  instance_type = "t2.micro"
  image_id      = "ami-096800910c1b781ba"

  network_interfaces {
    subnet_id       = aws_subnet.public-subnet-2.id
    security_groups = [aws_security_group.scgroup-1.id]
  }
  key_name = "Main-key"

}

#autoscaling group settings
resource "aws_autoscaling_group" "auto-scaling-grp-1" {
  name                 = "auto-scaling-grp-1"
  min_size             = 1
  max_size             = 3
  health_check_grace_period = 200
  health_check_type    = "EC2"
  force_delete         = true
   launch_template {
    id      = aws_launch_template.template-1.id
    version = "$Latest"
  }
  tag {
    key = "Name"
    value = "ec2-instance"
    propagate_at_launch = true
  }
}

#autoscaling policy
resource "aws_autoscaling_policy" "auto-policy-1" {
  name = "auto-policy-1"
  autoscaling_group_name = aws_autoscaling_group.auto-scaling-grp-1.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = 1
  cooldown = 100
  policy_type = "SimpleScaling"
}

#Monitoring autoscaling
resource "aws_cloudwatch_metric_alarm" "cpu-alarm-1" {
  alarm_name =  "cpu-alarm-1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CpuUsage"
  namespace = "AWS/EC2"
  period = 120 
  statistic = "Average"
  threshold = 20

  dimensions = {
    "AutoScalingGroupName" : aws_autoscaling_group.auto-scaling-grp-1.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.auto-policy-1.arn]
}

#descaling policy
resource "aws_autoscaling_policy" "deauto-policy-1" {
  name = "deauto-policy-1"
  autoscaling_group_name = aws_autoscaling_group.auto-scaling-grp-1.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = -1
  cooldown = 100
  policy_type = "SimpleScaling"
}

#Monitoring deautoscaling
resource "aws_cloudwatch_metric_alarm" "down-cpu-alarm-1" {
  alarm_name =  "down-cpu-alarm-1"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CpuUsage"
  namespace = "AWS/EC2"
  period = 120 
  statistic = "Average"
  threshold = 10

  dimensions = {
    "AutoScalingGroupName" : aws_autoscaling_group.auto-scaling-grp-1.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.auto-policy-1.arn]
}