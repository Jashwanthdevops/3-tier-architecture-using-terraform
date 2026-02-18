resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-template"
  image_id      = data.aws_ami.amzlinux.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install nginx -y
amazon-linux-extras install -y nginx1
systemctl enable nginx
systemctl start nginx
echo "<h1>Server: $(hostname)</h1>" > /usr/share/nginx/html/index.html
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-asg-instance"
    }
  }
}
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = aws_subnet.private[*].id

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.tg.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 60

  tag {
    key                 = "Name"
    value               = "web-asg"
    propagate_at_launch = true
  }
}
