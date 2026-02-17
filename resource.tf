resource "aws_instance" "web_public" {
  count         = 2
  instance_type = var.instance_type
  ami           = data.aws_ami.amzlinux.id

  subnet_id = aws_subnet.public[count.index].id

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  key_name = "nexus"

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
