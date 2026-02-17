resource "aws_instance" "web_public" {
  count         = 2
  instance_type = var.instance_type
  ami           = data.aws_ami.amzlinux.id

  subnet_id = aws_subnet.public[count.index].id

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  key_name = "nexus"
    user_data = <<EOF
#!/bin/bash
yum update -y
amazon-linux-extras install -y nginx1
systemctl enable nginx
systemctl start nginx
echo "<h1>Welcome to vcube! AWS infra created using Terraform</h1>" > /usr/share/nginx/html/index.html
EOF
  tags = {
    Name = "web-${count.index}"
  }
}
resource "aws_instance" "web" {
  count         = 2
  instance_type = var.instance_type
  ami           = data.aws_ami.amzlinux.id

  subnet_id = aws_subnet.private[count.index].id

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  key_name = "nexus"

  tags = {
    Name = "web-${count.index}"
  }
}
