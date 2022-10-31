resource "aws_instance" "webserver-1" {
  ami               = "ami-09d3b3274b6c5d4aa"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id         = aws_subnet.web-sub-1.id
  #user_data         = file("install_apache.sh")
  tags              = {
    Name            = "Web-server"
  }
}

resource "aws_vpc" "web-app-vpc" {
  cidr_block        = "10.0.0.0/16"
  tags              = {
    Name            = "Web-app"
  }
}

resource "aws_subnet" "web-sub-1" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags              = {
    Name            = "web-app-sub"
  }
}

resource "aws_subnet" "web-sub-2" {
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags              = {
    Name            = "web-app-sub"
  }
}

resource "aws_security_group" "web-sg" {
  name            = "Web-SG"
  description     = "Allow HTTP inbound traffic"
  vpc_id          = aws_vpc.web-app-vpc.id

  ingress {
    from_port     = 80
    protocol      = "tcp"
    to_port       = 80
    cidr_blocks   = ["0.0.0.0/0"]
  }

  egress {
    from_port     = 0
    protocol      = "-1"
    to_port       = 0
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags            = {
    Name          = "Web-SG"
  }
}