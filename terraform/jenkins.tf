





data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  key_name      = "key"
  subnet_id     = aws_subnet.public-us-east-1a.id
  vpc_security_group_ids = [aws_security_group.jenkins.id]

  tags = {
    Name = "jenkins-instance"
  }
}
